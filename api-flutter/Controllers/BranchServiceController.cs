using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using QueueManagerApi.Models;

namespace QueueManagerApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BranchServiceController : ControllerBase
    {
        private readonly ApplicationDbContext _db;

        public BranchServiceController(ApplicationDbContext db)
        {
            _db = db;
        }

        [HttpGet("branches")]
        public async Task<IActionResult> GetBranches()
        {
            var branches = await _db.Branches.ToListAsync();
            return Ok(branches);
        }

        [HttpGet("services/{branchId}")]
        public async Task<IActionResult> GetServices(int branchId)
        {
            var services = await _db.Services
                .Where(s => s.BranchId == branchId && s.IsActive)
                .ToListAsync();

            return Ok(services);
        }
        [HttpGet("services-by-domain")]
        public async Task<IActionResult> GetServicesByDomain([FromQuery] ServiceDomainType domainType)
        {
            var services = await _db.Services
                .Where(s => s.DomainType == domainType && s.IsActive)
                .ToListAsync();

            return Ok(services);
        }

    }
}
