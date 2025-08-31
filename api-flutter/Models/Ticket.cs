using System;

namespace QueueManagerApi.Models
{
    public enum DomainType { Court = 1, Hospital = 2 }
    public enum TicketStatus { Waiting = 0, Called = 1, Served = 2, Cancelled = 3, NoShow = 4 }

    public class Ticket
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public ServiceDomainType DomainType { get; set; }
        public int BranchId { get; set; }
        public int ServiceId { get; set; }
        public string QueueNumber { get; set; } = "";
        public TicketStatus Status { get; set; } = TicketStatus.Waiting;
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime? EstimatedStartTime { get; set; }

        // بيانات الجيست
        public string? GuestName { get; set; }
        public string? GuestEmail { get; set; }
        public string? GuestPhone { get; set; }

        // بيانات لو يوزر مسجل
        public string? UserId { get; set; }
    }
}
