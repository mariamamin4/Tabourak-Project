using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QueueManagerApi.Models;
using QueueManagerApi.Services;
using System;
using System.Security.Claims;
using System.Threading.Tasks;

namespace QueueManagerApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookingController : ControllerBase
    {
        private readonly ApplicationDbContext _db;
        private readonly QueueService _queueService;
        private readonly NotificationService _notificationService;

        public BookingController(ApplicationDbContext db, QueueService queueService, NotificationService notificationService)
        {
            _db = db;
            _queueService = queueService;
            _notificationService = notificationService;
        }

        [HttpPost("book-as-guest")]
        [AllowAnonymous]
        public async Task<IActionResult> BookAsGuest([FromBody] GuestBookingDto dto)
        {
            var service = await _db.Services.FindAsync(dto.ServiceId);
            if (service == null) return BadRequest("Service not found");

            var branch = await _db.Branches.FindAsync(dto.BranchId);
            if (branch == null) return BadRequest("Branch not found");

            var queueNumber = await _queueService.GenerateQueueNumberAsync(dto.BranchId, dto.ServiceId);

            var ticket = new Ticket
            {
                DomainType = service.DomainType,
                BranchId = dto.BranchId,
                ServiceId = dto.ServiceId,
                QueueNumber = queueNumber,
                GuestName = dto.FullName,
                GuestEmail = dto.Email,
                GuestPhone = dto.PhoneNumber
            };

            // حساب الوقت المقدر للدور
            ticket.EstimatedStartTime = await _queueService.CalculateEstimatedTimeAsync(dto.BranchId, dto.ServiceId);

            _db.Tickets.Add(ticket);
            await _db.SaveChangesAsync();

            // إنشاء Notification قبل الدور بعشر دقايق
            if (!string.IsNullOrEmpty(dto.Email))
            {
                var notifyTime = ticket.EstimatedStartTime.Value.AddMinutes(-10);
                var notification = new Notification
                {
                    UserId = dto.Email, // نقدر نستخدم الإيميل كمعرف للجيست
                    Message = $"دورك قرب! فاضل 10 دقايق 🎉",
                    ScheduledTime = notifyTime,
                    IsSent = false
                };
                _db.Notifications.Add(notification);
                await _db.SaveChangesAsync();
            }

            return Ok(new
            {
                ticket.Id,
                ticket.QueueNumber,
                ticket.Status,
                FullName = dto.FullName,
                ServiceName = service.Name,
                BranchName = branch.Name,
                EstimatedStartTime = ticket.EstimatedStartTime,
                CreatedAt = ticket.CreatedAt
            });
        }

        [HttpPost("book-as-user")]
        [Authorize]
        public async Task<IActionResult> BookAsUser([FromBody] UserBookingDto dto)
        {
            var service = await _db.Services.FindAsync(dto.ServiceId);
            if (service == null) return BadRequest("Service not found");

            var branch = await _db.Branches.FindAsync(dto.BranchId);
            if (branch == null) return BadRequest("Branch not found");

            var queueNumber = await _queueService.GenerateQueueNumberAsync(dto.BranchId, dto.ServiceId);

            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            var ticket = new Ticket
            {
                DomainType = service.DomainType,
                BranchId = dto.BranchId,
                ServiceId = dto.ServiceId,
                QueueNumber = queueNumber,
                UserId = userId
            };

            // حساب الوقت المقدر للدور
            ticket.EstimatedStartTime = await _queueService.CalculateEstimatedTimeAsync(dto.BranchId, dto.ServiceId);

            _db.Tickets.Add(ticket);
            await _db.SaveChangesAsync();

            // إنشاء Notification قبل الدور بعشر دقايق
            if (!string.IsNullOrEmpty(userId))
            {
                var notifyTime = ticket.EstimatedStartTime.Value.AddMinutes(-10);
                var notification = new Notification
                {
                    UserId = userId,
                    Message = $"دورك قرب! فاضل 10 دقايق 🎉",
                    ScheduledTime = notifyTime,
                    IsSent = false
                };
                _db.Notifications.Add(notification);
                await _db.SaveChangesAsync();
            }

            return Ok(new
            {
                ticket.Id,
                ticket.QueueNumber,
                ticket.Status,
                FullName = User.Identity?.Name,
                ServiceName = service.Name,
                BranchName = branch.Name,
                EstimatedStartTime = ticket.EstimatedStartTime,
                CreatedAt = ticket.CreatedAt
            });
        }
        [HttpGet("position/{ticketId}")]
        public async Task<IActionResult> GetPosition(Guid ticketId)
        {
            try
            {
                var ticket = await _db.Tickets.FindAsync(ticketId);
                if (ticket == null) return NotFound("Ticket not found");

                var service = await _db.Services.FindAsync(ticket.ServiceId);
                if (service == null) return NotFound("Service not found");

                var position = await _queueService.GetUserPositionAsync(ticketId);

                // التأكد من أن position ليس صفر أو قيمة غير صالحة
                if (position <= 0)
                {
                    return Ok(new
                    {
                        TicketId = ticket.Id,
                        TicketNumber = ticket.QueueNumber,
                        Position = position,
                        PeopleInFront = 0,
                        EstimatedWaitingTime = "00:00:00",
                        EstimatedStartTime = DateTime.UtcNow
                    });
                }

                var peopleInFront = position - 1;

                // التأكد من أن peopleInFront ليس سالب
                if (peopleInFront < 0) peopleInFront = 0;

                var waitingMinutes = peopleInFront * service.DurationInMinutes;
                var waitingTime = TimeSpan.FromMinutes(waitingMinutes);

                return Ok(new
                {
                    TicketId = ticket.Id,
                    TicketNumber = ticket.QueueNumber,
                    Position = position,
                    PeopleInFront = peopleInFront,
                    EstimatedWaitingTime = waitingTime.ToString(@"hh\:mm\:ss"),
                    EstimatedStartTime = DateTime.UtcNow.Add(waitingTime)
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

    }
}
