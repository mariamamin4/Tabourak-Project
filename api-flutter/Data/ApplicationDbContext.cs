using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using QueueManagerApi.Models;

public class ApplicationDbContext : IdentityDbContext<AppUser>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

    public DbSet<Ticket> Tickets { get; set; }
    public DbSet<Branch> Branches { get; set; }
    public DbSet<Service> Services { get; set; }
    public DbSet<Notification> Notifications { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        // إضافة بيانات الفروع
        builder.Entity<Branch>().HasData(
            new Branch { Id = 1, Name = "محكمة القاهرة", Address = "شارع المحكمة الرئيسي" },
            new Branch { Id = 2, Name = "مستشفى السلام", Address = "شارع المستشفى العام" }
        );

        // إضافة بيانات الخدمات
        builder.Entity<Service>().HasData(
     // خدمات المحكمة
     new Service { Id = 1, BranchId = 1, Name = "قيد دعوى", DomainType = ServiceDomainType.Court, IsActive = true, DurationInMinutes = 20 },
     new Service { Id = 2, BranchId = 1, Name = "إستخراج شهادة", DomainType = ServiceDomainType.Court, IsActive = true, DurationInMinutes = 15 },
     new Service { Id = 3, BranchId = 1, Name = "توثيق عقد", DomainType = ServiceDomainType.Court, IsActive = true, DurationInMinutes = 25 },

     // خدمات المستشفى
     new Service { Id = 4, BranchId = 2, Name = "كشف باطنة", DomainType = ServiceDomainType.Hospital, IsActive = true, DurationInMinutes = 20 },
     new Service { Id = 5, BranchId = 2, Name = "كشف عظام", DomainType = ServiceDomainType.Hospital, IsActive = true, DurationInMinutes = 30 },
     new Service { Id = 6, BranchId = 2, Name = "تحاليل طبية", DomainType = ServiceDomainType.Hospital, IsActive = true, DurationInMinutes = 40 }
 );
    }
}
