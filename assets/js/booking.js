document.addEventListener("DOMContentLoaded", () => {
  const bookingForm = document.getElementById("bookingForm");
    if (!bookingForm) return; 

  bookingForm.addEventListener("submit", (e) => {
    e.preventDefault();

    const loggedInUser = JSON.parse(localStorage.getItem("loggedInUser"));
    const bookings = JSON.parse(localStorage.getItem("bookings")) || [];

    const service = document.getElementById("service").value;
    const branch = document.getElementById("branch").value;

    // 🔹 مفتاح خاص بكل (branch + service)
    const counterKey = `lastTicketNumber_${branch}_${service}`;

    // 🔹 نجيب آخر رقم للتذكرة للفرع + الخدمة دي فقط
    let lastTicketNumber = parseInt(localStorage.getItem(counterKey)) || 0;
    lastTicketNumber++;
    localStorage.setItem(counterKey, lastTicketNumber);

    // 🔹 نعد كام واحد لسه مستنيين في نفس الفرع والخدمة
    const waitingCount = bookings.filter(
      (b) => b.branch === branch && b.service === service && b.status === "waiting"
    ).length;

    const newBooking = {
      id: Date.now(),
      username: loggedInUser?.username,
      service: service,
      branch: branch,
      ticketNumber: lastTicketNumber,
      status: "waiting",
      date: new Date().toLocaleDateString(),
      time: new Date().toLocaleTimeString(),
      wait: waitingCount, 
    };

    bookings.push(newBooking);
    localStorage.setItem("bookings", JSON.stringify(bookings));
    localStorage.setItem("currentBooking", JSON.stringify(newBooking));

    window.location.href = "ticket.html";
  });
});



document.addEventListener("DOMContentLoaded", () => {
  const branchSelect = document.getElementById("branch");
  const serviceSelect = document.getElementById("service");

  // الخدمات حسب الفروع
  const servicesByBranch = {
    hospital: [
      { value: "checkup", text: "Medical Check-up" },
      { value: "dentist", text: "Dental Consultation" },
      { value: "lab", text: "Lab Tests" }
    ],
    clinic: [
      { value: "consult", text: "Doctor Consultation" },
      { value: "xray", text: "X-Ray" }
    ],
    bank: [
      { value: "cash", text: "Cash Withdrawal" },
      { value: "deposit", text: "Deposit" },
      { value: "loan", text: "Loan Inquiry" }
    ],
    gov: [
      { value: "license", text: "License Renewal" },
      { value: "id", text: "National ID Renewal" },
      { value: "passport", text: "Passport Services" }
    ],
    post: [
      { value: "delivery", text: "Parcel Pickup" },
      { value: "inquiry", text: "General Inquiry" }
    ]
  };

  // لما يختار فرع
  branchSelect.addEventListener("change", function () {
    const branch = this.value;
    serviceSelect.innerHTML = '<option value="">Select service</option>'; // مسح القديم

    if (branch && servicesByBranch[branch]) {
      servicesByBranch[branch].forEach(service => {
        const option = document.createElement("option");
        option.value = service.value;
        option.textContent = service.text;
        serviceSelect.appendChild(option);
      });
    }
  });
});

