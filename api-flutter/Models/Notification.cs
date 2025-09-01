namespace QueueManagerApi.Models
{
    public class Notification
    {
        public int Id { get; set; }

        // المستخدم اللي النوتفكيشن يخصه
        public string UserId { get; set; }

        public string Message { get; set; }

        // الوقت اللي المفروض يتبعت فيه
        public DateTime ScheduledTime { get; set; }

        // علشان نعرف هل اتبعت ولا لأ
        public bool IsSent { get; set; }
    }
}
