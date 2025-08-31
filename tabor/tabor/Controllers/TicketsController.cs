using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using tabor.Data;
using tabor.Models;

namespace tabor.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TicketsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TicketsController(AppDbContext context)
        {
            _context = context;
        }

        //  GET: api/tickets
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Ticket>>> GetTickets()
        {
            return await _context.Tickets.ToListAsync();
        }

        //  GET: api/tickets/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Ticket>> GetTicket(long id)
        {
            var ticket = await _context.Tickets.FindAsync(id);

            if (ticket == null)
            {
                return NotFound();
            }

            return ticket;
        }

        //  POST: api/tickets
        [HttpPost]
        public async Task<ActionResult<Ticket>> PostTicket(Ticket ticket)
        {
            //  EF مش هيولد Id، هنستخدم اللي جاي من الفرونت (Date.now)
            _context.Tickets.Add(ticket);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetTicket), new { id = ticket.Id }, ticket);
        }

        //  PUT: api/tickets/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTicket(long id, Ticket ticket)
        {
            if (id != ticket.Id)
            {
                return BadRequest();
            }

            _context.Entry(ticket).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TicketExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        //  DELETE: api/tickets/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTicket(long id)
        {
            var ticket = await _context.Tickets.FindAsync(id);
            if (ticket == null)
            {
                return NotFound();
            }

            _context.Tickets.Remove(ticket);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool TicketExists(long id)
        {
            return _context.Tickets.Any(e => e.Id == id);
        }
    }
}
