using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using tabor.Data;
using tabor.Models;

namespace tabor.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UsersController(AppDbContext context)
        {
            _context = context;
        }

        //  Sign Up
        [HttpPost("signup")]
        public async Task<ActionResult<User>> SignUp(User user)
        {
            // check if username already exists
            var existingUser = await _context.Users
                .FirstOrDefaultAsync(u => u.Username == user.Username);

            if (existingUser != null)
            {
                return BadRequest("Username already exists");
            }

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return Ok(user);
        }

        //  Login
        [HttpPost("login")]
        public async Task<ActionResult<User>> Login(User loginUser)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u =>
                    u.Username == loginUser.Username &&
                    u.Password == loginUser.Password);

            if (user == null)
            {
                return Unauthorized("Invalid username or password");
            }

            return Ok(user);
        }
    }
}
