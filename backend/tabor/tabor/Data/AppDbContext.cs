using Microsoft.EntityFrameworkCore;
using tabor.Models;

namespace tabor.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Ticket> Tickets { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Ticket>()
                .Property(t => t.Id)
                .ValueGeneratedNever();   //   استخدم القيمة اللي جاية من الفرونت
            
        }
            public DbSet<User> Users { get; set; }       // جدول المستخدمين
    }
    
}
