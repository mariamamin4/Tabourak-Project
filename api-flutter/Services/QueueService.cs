using Microsoft.EntityFrameworkCore;
using QueueManagerApi.Models;
using System;

namespace QueueManagerApi.Services
{
    public class QueueService
    {
        private readonly ApplicationDbContext _db;
        public QueueService(ApplicationDbContext db) { _db = db; }

        public async Task<string> GenerateQueueNumberAsync(int branchId, int serviceId)
        {
            var today = DateTime.UtcNow.Date;
            var countToday = await _db.Tickets
                .CountAsync(t => t.BranchId == branchId && t.ServiceId == serviceId && t.CreatedAt >= today);

            return $"B-{countToday + 1:000}";
        }
        public async Task<DateTime> CalculateEstimatedTimeAsync(int branchId, int serviceId)
        {
            var service = await _db.Services.FindAsync(serviceId);
            if (service == null) throw new Exception("Service not found");

            var todayTickets = await _db.Tickets
                .Where(t => t.BranchId == branchId && t.ServiceId == serviceId && t.CreatedAt.Date == DateTime.UtcNow.Date)
                .ToListAsync();

            var waitingMinutes = todayTickets.Count * service.DurationInMinutes;

            return DateTime.UtcNow.AddMinutes(waitingMinutes);
        }
        public async Task<int> GetUserPositionAsync(Guid ticketId)
        {
            var ticket = await _db.Tickets.FindAsync(ticketId);
            if (ticket == null) throw new Exception("Ticket not found");

            var position = await _db.Tickets
                .CountAsync(t =>
                    t.BranchId == ticket.BranchId &&
                    t.ServiceId == ticket.ServiceId &&
                    t.Status == TicketStatus.Waiting &&
                    string.Compare(t.QueueNumber, ticket.QueueNumber) < 0
                );
            return position + 1;
        }

    }
}
