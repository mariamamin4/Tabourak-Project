using MailKit.Net.Smtp;
using MimeKit;
namespace QueueManagerApi.Services
{
    using MailKit.Net.Smtp;
    using MailKit.Security;
    using MimeKit;

    public class EmailSender : IEmailSender
    {
        private readonly IConfiguration _config;

        public EmailSender(IConfiguration config)
        {
            _config = config;
        }

        public async Task SendEmailAsync(string email, string subject, string message)
        {
            var emailMessage = new MimeMessage();
            emailMessage.From.Add(new MailboxAddress("Queue Manager", _config["EmailSettings:SenderEmail"]));
            emailMessage.To.Add(new MailboxAddress("", email));
            emailMessage.Subject = subject;
            emailMessage.Body = new TextPart("plain") { Text = message };

            using var client = new SmtpClient();

            // إضافة هذه السطر لتجاوز التحقق من SSL (للتطوير فقط)
            client.ServerCertificateValidationCallback = (s, c, h, e) => true;

            // استخدم SecureSocketOptions.Auto بدلاً من false
            await client.ConnectAsync(
                _config["EmailSettings:SmtpServer"],
                int.Parse(_config["EmailSettings:SmtpPort"]),
                SecureSocketOptions.Auto);

            await client.AuthenticateAsync(
                _config["EmailSettings:SenderEmail"],
                _config["EmailSettings:SenderPassword"]);

            await client.SendAsync(emailMessage);
            await client.DisconnectAsync(true);
        }
    }
}
