namespace tabor.Models
{
    public class Ticket
    {

       
            public long Id { get; set; }   
            public string Username { get; set; } = string.Empty;
            public string Service { get; set; } = string.Empty;
            public string Branch { get; set; } = string.Empty;
            public int TicketNumber { get; set; }
            public string Status { get; set; } = "waiting";
            public string Date { get; set; } = string.Empty;
            public string Time { get; set; } = string.Empty;
            public string Wait { get; set; } = string.Empty;
        


    }
}
