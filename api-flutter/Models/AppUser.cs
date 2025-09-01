using Microsoft.AspNetCore.Identity;
namespace QueueManagerApi.Models
{
    public class AppUser : IdentityUser
    {
        public string? FullName { get; set; }
        public string? ProfilePicture { get; set; }
        public string? OtpCode { get; set; }  // بدل TwoFactorToken، عشان OTP
        public DateTime? OtpExpiry { get; set; }  // للانتهاء بعد 5 دقائق
    }
}
