document.addEventListener("DOMContentLoaded", () => {
  const queueTable = document.getElementById("queueTable");
  const clearBtn = document.getElementById("clearAllBtn");
  const callNextBtn = document.getElementById("callNextBtn");

  const loggedInUser = JSON.parse(localStorage.getItem("loggedInUser"));
  if (!loggedInUser || loggedInUser.role !== "admin") {
    alert("Access denied! Admins only.");
    window.location.href = "index.html";
    return;
  }

  let bookings = JSON.parse(localStorage.getItem("bookings")) || [];

  function renderQueue() {
    queueTable.innerHTML = "";

    if (bookings.length === 0) {
      queueTable.innerHTML = `
        <tr>
          <td colspan="6" class="text-center text-muted">No bookings in the queue.</td>
        </tr>`;
      return;
    }

    bookings.forEach((booking, index) => {
      const row = document.createElement("tr");

      row.innerHTML = `
        <td><span class="fw-bold">${booking.ticketNumber}</span></td>
        <td>${booking.username}</td>
        <td>${booking.branch}</td>
        <td>${booking.service}</td>
        <td>
          <span class="badge ${booking.status === "called" ? "bg-success" : "bg-secondary"}">
            ${booking.status}
          </span>
        </td>
        <td>
          <button class="btn btn-success btn-sm me-2 callBtn">Call</button>
          <button class="btn btn-danger btn-sm deleteBtn">Delete</button>
        </td>
      `;

      // Call button
      row.querySelector(".callBtn").addEventListener("click", () => {
        booking.status = "called";
        localStorage.setItem("bookings", JSON.stringify(bookings));
        localStorage.setItem("currentBooking", JSON.stringify(booking));
        renderQueue();
      });

      // Delete button
      row.querySelector(".deleteBtn").addEventListener("click", () => {
        bookings.splice(index, 1);
        localStorage.setItem("bookings", JSON.stringify(bookings));
        localStorage.removeItem("currentBooking");
        renderQueue();
      });

      queueTable.appendChild(row);
    });
  }

  // Clear All
  clearBtn.addEventListener("click", () => {
    if (confirm("Are you sure you want to clear all bookings?")) {
      bookings = [];
      localStorage.setItem("bookings", JSON.stringify(bookings));
      localStorage.removeItem("currentBooking");
      renderQueue();
    }
  });

  // Call Next (أول واحد في الطابور)
  callNextBtn.addEventListener("click", () => {
    if (bookings.length > 0) {
      bookings[0].status = "called";
      localStorage.setItem("bookings", JSON.stringify(bookings));
      localStorage.setItem("currentBooking", JSON.stringify(bookings[0]));
      renderQueue();
    } else {
      alert("No bookings available.");
    }
  });

  renderQueue();
});
