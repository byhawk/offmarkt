// Auth helper functions

function checkAuth() {
    const token = localStorage.getItem('adminToken');
    const adminUser = localStorage.getItem('adminUser');

    // If not logged in, redirect to login page
    if (!token || !adminUser) {
        window.location.href = '/login.html';
        return false;
    }

    // Display admin info in sidebar
    try {
        const admin = JSON.parse(adminUser);
        const adminInfoEl = document.getElementById('adminInfo');
        if (adminInfoEl) {
            adminInfoEl.innerHTML = `
                <strong>${admin.username}</strong><br>
                <small>${admin.role}</small>
            `;
        }
    } catch (e) {
        console.error('Failed to parse admin user:', e);
        logout();
        return false;
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

// Check auth on page load (only for non-login pages)
if (window.location.pathname !== '/login.html' && !window.authChecked) {
    window.authChecked = true;
    checkAuth();
}
