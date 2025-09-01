using System.ComponentModel.DataAnnotations;

namespace QueueManagerApi.Models
{
    public class UpdateProfileDto
    {
        [Required]
        public string FullName { get; set; }
        [Required]
        [EmailAddress]
        public string Email { get; set; }
    }
}
