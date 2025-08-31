using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using QueueManagerApi.Models;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace QueueManagerApi.Services
{
    public class NotificationBackgroundService : BackgroundService
    {
        private readonly IServiceScopeFactory _scopeFactory;

        public NotificationBackgroundService(IServiceScopeFactory scopeFactory)
        {
            _scopeFactory = scopeFactory;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                using (var scope = _scopeFactory.CreateScope())
                {
                    var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
                    var notificationService = scope.ServiceProvider.GetRequiredService<NotificationService>();

                    var now = DateTime.UtcNow;
                    var notifications = await db.Notifications
                        .Where(n => !n.IsSent && n.ScheduledTime <= now)
                        .ToListAsync();

                    foreach (var n in notifications)
                    {
                        await notificationService.SendNowAsync(n.UserId, n.Message);
                        n.IsSent = true;
                    }

                    await db.SaveChangesAsync();
                }

                await Task.Delay(TimeSpan.FromSeconds(60), stoppingToken); // تحقق كل دقيقة
            }
        }
    }
}
