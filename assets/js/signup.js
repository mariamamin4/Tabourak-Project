document.getElementById('signupForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const username = document.getElementById('username').value.trim().toLowerCase();
    const password = document.getElementById('password').value.trim();
    const role = document.getElementById('role').value;

    if (!username || !password || !role) {
        alert("Please fill all fields");
        return;
    }

    // جلب كل المستخدمين الحاليين
    let users = JSON.parse(localStorage.getItem("users")) || [];

    // التأكد إذا اسم المستخدم موجود قبل كده
    if (users.some(user => user.username === username)) {
        alert("Username already exists!");
        return;
    }

    // إضافة المستخدم الجديد
    users.push({ username, password, role });
    localStorage.setItem("users", JSON.stringify(users));

    alert("Account created successfully! Please login.");
    window.location.href = "login.html";
});
