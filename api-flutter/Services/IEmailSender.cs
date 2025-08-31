using System.Threading.Tasks;
namespace QueueManagerApi.Services
{
    public interface IEmailSender
    {
        Task SendEmailAsync(string email, string subject, string message);
    }
}
