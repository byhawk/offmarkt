// Auth helper functions
function checkAuth() {
    const token = localStorage.getItem('adminToken');
    const adminUser = localStorage.getItem('adminUser');
    
    if (!token || !adminUser) {
        window.location.href = '/login.html';
        return false;
    }
    
    // Display admin info
    const admin = JSON.parse(adminUser);
    const adminInfoEl = document.getElementById('adminInfo');
    if (adminInfoEl) {
        adminInfoEl.innerHTML = `
            <strong>${admin.username}</strong><br>
            <small>${admin.role}</small>
        `;
    }
    
    return true;
}

function logout() {
    if (confirm('Çıkış yapmak istediğinizden emin misiniz?')) {
        localStorage.removeItem('adminToken');
        localStorage.removeItem('adminUser');
        window.location.href = '/login.html';
    }
}

function getToken() {
    return localStorage.getItem('adminToken');
}

// Check auth on page load
if (window.location.pathname !== '/login.html') {
    checkAuth();
}
