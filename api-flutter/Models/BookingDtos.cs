namespace QueueManagerApi.Models
{
    public class GuestBookingDto
    {
        public string FullName { get; set; } = "";
        public string Email { get; set; } = "";
        public string PhoneNumber { get; set; } = "";
        public int BranchId { get; set; }
        public int ServiceId { get; set; }
    }

    public class UserBookingDto
    {
        public int BranchId { get; set; }
        public int ServiceId { get; set; }
    }
}
