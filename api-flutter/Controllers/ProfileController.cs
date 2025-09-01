using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using QueueManagerApi.Models;
using System.Threading.Tasks;

namespace QueueManagerApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ProfileController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;

        public ProfileController(UserManager<AppUser> userManager)
        {
            _userManager = userManager;
        }

        // GET: api/profile
        [HttpGet]
        public async Task<ActionResult<UserProfileDto>> GetProfile()
        {
            var user = await _userManager.GetUserAsync(User);
            if (user == null)
            {
                return NotFound("المستخدم غير موجود");
            }

            var profile = new UserProfileDto
            {
                FullName = user.FullName,
                Email = user.Email,
                ProfilePicture = user.ProfilePicture ?? "https://via.placeholder.com/150" // صورة افتراضية لو مش موجودة
            };

            return Ok(profile);
        }

        // PUT: api/profile
        [HttpPut]
        public async Task<IActionResult> UpdateProfile([FromBody] UpdateProfileDto model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _userManager.GetUserAsync(User);
            if (user == null)
            {
                return NotFound("المستخدم غير موجود");
            }

            // تحديث الاسم والإيميل
            user.FullName = model.FullName;
            user.Email = model.Email;
            user.UserName = model.Email; // تحديث UserName ليطابق الإيميل

            var result = await _userManager.UpdateAsync(user);
            if (result.Succeeded)
            {
                return Ok("تم تحديث البيانات بنجاح");
            }

            return BadRequest(result.Errors);
        }

        // PUT: api/profile/change-password
        [HttpPut("change-password")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordDto model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _userManager.GetUserAsync(User);
            if (user == null)
            {
                return NotFound("المستخدم غير موجود");
            }

            // التحقق من كلمة المرور الحالية
            var passwordCheck = await _userManager.CheckPasswordAsync(user, model.CurrentPassword);
            if (!passwordCheck)
            {
                return BadRequest("كلمة المرور الحالية غير صحيحة");
            }

            // تغيير كلمة المرور
            var result = await _userManager.ChangePasswordAsync(user, model.CurrentPassword, model.NewPassword);
            if (result.Succeeded)
            {
                return Ok("تم تغيير كلمة المرور بنجاح");
            }

            return BadRequest(result.Errors);
        }
    }
}