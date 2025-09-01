namespace QueueManagerApi.Models
{
    public class Service
    {
        public int Id { get; set; }
        public int BranchId { get; set; }
        public string Name { get; set; } = "";
        public ServiceDomainType DomainType { get; set; }
        public bool IsActive { get; set; } = true;
        // الوقت المحدد لكل خدمة (بالدقايق)
        public int DurationInMinutes { get; set; } = 20;
        public Branch Branch { get; set; }
    }
}
