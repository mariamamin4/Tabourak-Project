namespace tabor.Models
{
    public class User
    {

        public int Id { get; set; }                // primary key (auto)
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty; // لاحقاً نقدر نعمل hash لو حبّيت


    }
}
