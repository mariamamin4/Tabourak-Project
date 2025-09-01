using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using QueueManagerApi.Models;
using QueueManagerApi.Services;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QueueManagerApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class NotificationsController : ControllerBase
    {
        private readonly ApplicationDbContext _db;
        private readonly NotificationService _notificationService;

        public NotificationsController(ApplicationDbContext db, NotificationService notificationService)
        {
            _db = db;
            _notificationService = notificationService;
        }

        [HttpPost("test-now")]
        public async Task<IActionResult> TestNow([FromBody] TestNotificationRequest req)
        {
            await _notificationService.SendNowAsync(req.UserId, req.Message);
            return Ok(new { ok = true });
        }

        [HttpGet("unread/{userId}")]
        public async Task<IActionResult> GetUnread(string userId)
        {
            var notifications = await _db.Notifications
                .Where(n => n.UserId == userId && !n.IsSent && n.ScheduledTime <= System.DateTime.UtcNow)
                .ToListAsync();

            foreach (var n in notifications)
                n.IsSent = true;

            await _db.SaveChangesAsync();

            return Ok(notifications);
        }
    }

    public class TestNotificationRequest
    {
        public string UserId { get; set; } = string.Empty;
        public string Message { get; set; } = "دورك قرب! فاضل 10 دقايق 🎉";
    }
}
