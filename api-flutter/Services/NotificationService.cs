using Microsoft.EntityFrameworkCore;
using System.Net.Mail;
using System.Threading.Tasks;

namespace QueueManagerApi.Services
{
    public class NotificationService
    {
        private readonly ApplicationDbContext _db;
        private readonly IEmailSender _emailSender;

        public NotificationService(ApplicationDbContext db, IEmailSender emailSender)
        {
            _db = db;
            _emailSender = emailSender;
        }

        public async Task SendNowAsync(string userIdOrEmail, string message)
        {
            // 1. حاول نفترض إن userIdOrEmail هو إيميل
            var email = userIdOrEmail;

            // 2. لو مش إيميل صالح، نفترض إنه user id وندور على إيميل من جدول Users
            if (!IsValidEmail(email))
            {
                var user = await _db.Users
                    .Where(u => u.Id.ToString() == userIdOrEmail || u.Id == userIdOrEmail)
                    .FirstOrDefaultAsync();

                if (user != null)
                    email = user.Email;
            }

            if (string.IsNullOrEmpty(email)) return;

            // 3. ابعت الإيميل فعليًا
            var subject = "تنبيه: دورك قرب";
            var body = message;

            await _emailSender.SendEmailAsync(email, subject, body);
        }

        private bool IsValidEmail(string email)
        {
            if (string.IsNullOrEmpty(email)) return false;
            try
            {
                var addr = new MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
    }
}
