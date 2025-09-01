using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using QueueManagerApi.Models;
using QueueManagerApi.Services;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System.IdentityModel.Tokens.Jwt;
using System.ComponentModel.DataAnnotations;

namespace QueueManagerApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IEmailSender _emailSender;
        private readonly IConfiguration _configuration;

        public AuthController(
            UserManager<AppUser> userManager,
            SignInManager<AppUser> signInManager,
            IEmailSender emailSender,
            IConfiguration configuration)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _emailSender = emailSender;
            _configuration = configuration;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginModel model)
        {
            var user = await _userManager.FindByEmailAsync(model.Email);
            if (user == null)
            {
                return Unauthorized("Invalid email or password");
            }

            var result = await _signInManager.PasswordSignInAsync(user, model.Password, model.RememberMe, false);
            if (!result.Succeeded)
            {
                return Unauthorized("Invalid email or password");
            }

            var token = GenerateJwtToken(user);
            return Ok(new
            {
                Token = token,
                FullName = user.FullName // هيرجع الاسم مع التوكن
            });
        }
        [Authorize]
        [HttpGet("welcome")]
        public IActionResult Welcome()
        {
            var fullName = User.FindFirst("FullName")?.Value;

            if (string.IsNullOrEmpty(fullName))
                return BadRequest("Full name not found in token");

            return Ok(new
            {
                message = $"Hello {fullName} 👋",
                fullName = fullName
            });
        }

        [HttpPost("forgot-password")]
        public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordModel model)
        {
            var user = await _userManager.FindByEmailAsync(model.Email);
            if (user == null)
            {
                // لا نريد الكشف عن أن البريد غير موجود لأسباب أمنية
                return Ok("If your email is registered, you will receive a reset code");
            }

            // إنشاء كود OTP من 6 أرقام
            var otpCode = new Random().Next(100000, 999999).ToString();
            user.OtpCode = otpCode;
            user.OtpExpiry = DateTime.UtcNow.AddMinutes(5); // صلاحية 5 دقائق

            await _userManager.UpdateAsync(user);

            // إرسال البريد الإلكتروني
            var emailSubject = "Password Reset Code";
            var emailMessage = $"Your password reset code is: {otpCode}. This code will expire in 5 minutes.";

            await _emailSender.SendEmailAsync(user.Email, emailSubject, emailMessage);

            return Ok("If your email is registered, you will receive a reset code");
        }

        [HttpPost("reset-password")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordModel model)
        {
            var user = await _userManager.FindByEmailAsync(model.Email);
            if (user == null || user.OtpCode != model.OtpCode || user.OtpExpiry < DateTime.UtcNow)
            {
                return BadRequest("Invalid or expired OTP code");
            }

            // إعادة تعيين كلمة المرور
            var token = await _userManager.GeneratePasswordResetTokenAsync(user);
            var result = await _userManager.ResetPasswordAsync(user, token, model.NewPassword);

            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            // مسح كود OTP بعد الاستخدام
            user.OtpCode = null;
            user.OtpExpiry = null;
            await _userManager.UpdateAsync(user);

            return Ok("Password has been reset successfully");
        }

        [HttpGet("google-login")]
        public IActionResult GoogleLogin()
        {
            var redirectUrl = Url.Action("GoogleResponse", "Auth");
            var properties = _signInManager.ConfigureExternalAuthenticationProperties("Google", redirectUrl);
            return Challenge(properties, "Google");
        }

        [HttpGet("google-response")]
        public async Task<IActionResult> GoogleResponse()
        {
            var info = await _signInManager.GetExternalLoginInfoAsync();
            if (info == null)
            {
                return BadRequest("Error loading external login information.");
            }

            var result = await _signInManager.ExternalLoginSignInAsync(info.LoginProvider, info.ProviderKey, false);
            if (result.Succeeded)
            {
                var user = await _userManager.FindByLoginAsync(info.LoginProvider, info.ProviderKey);
                var token = GenerateJwtToken(user);
                return Ok(new { Token = token });
            }

            // إذا كان المستخدم جديداً
            var email = info.Principal.FindFirstValue(ClaimTypes.Email);
            var userByEmail = await _userManager.FindByEmailAsync(email);
            if (userByEmail != null)
            {
                return BadRequest("Email already exists with another account");
            }

            var newUser = new AppUser
            {
                UserName = email,
                Email = email,
                EmailConfirmed = true
            };

            var createResult = await _userManager.CreateAsync(newUser);
            if (!createResult.Succeeded)
            {
                return BadRequest(createResult.Errors);
            }

            await _userManager.AddLoginAsync(newUser, info);
            await _signInManager.SignInAsync(newUser, false);

            var newToken = GenerateJwtToken(newUser);
            return Ok(new { Token = newToken });
        }
        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] RegisterModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (!model.AcceptPolicy)
            {
                return BadRequest("You must accept the terms and conditions");
            }

            var userExists = await _userManager.FindByEmailAsync(model.Email);
            if (userExists != null)
            {
                return BadRequest("Email already exists");
            }

            var user = new AppUser
            {
                UserName = model.Email,
                Email = model.Email,
                FullName = model.FullName
            };

            var result = await _userManager.CreateAsync(user, model.Password);
            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            // إرسال بريد الترحيب (اختياري)
            var emailSubject = "Welcome to Queue Manager";
            var emailMessage = $"Hello {model.FullName},\n\nThank you for registering with us!";

            await _emailSender.SendEmailAsync(model.Email, emailSubject, emailMessage);

            return Ok(new { Message = "Registration successful" });
        }

        private string GenerateJwtToken(AppUser user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Secret"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Id),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
                new Claim("FullName", user.FullName ?? ""),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var token = new JwtSecurityToken(
                issuer: null,
                audience: null,
                claims: claims,
                expires: DateTime.Now.AddDays(7),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }

    public class LoginModel
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public bool RememberMe { get; set; }
    }

    public class ForgotPasswordModel
    {
        public string Email { get; set; }
    }

    public class ResetPasswordModel
    {
        public string Email { get; set; }
        public string OtpCode { get; set; }
        public string NewPassword { get; set; }
        public string ConfirmPassword { get; set; }
    }
    public class RegisterModel
    {
        [Required]
        public string FullName { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        [Range(typeof(bool), "true", "true", ErrorMessage = "You must accept the terms and conditions")]
        public bool AcceptPolicy { get; set; }
    }
}