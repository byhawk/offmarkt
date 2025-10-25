// Sidebar HTML template
const SIDEBAR_HTML = `
<aside class="sidebar">
    <div class="logo">
        <h2>Deal Baron Admin</h2>
        <p>Yönetim Paneli</p>
    </div>
    <nav class="nav-menu">
        <a href="index.html" class="nav-item" data-page="index">
            <span>📊</span> Dashboard
        </a>
        <a href="players.html" class="nav-item" data-page="players">
            <span>👥</span> Oyuncular
        </a>
        <a href="products.html" class="nav-item" data-page="products">
            <span>📦</span> Ürünler
        </a>
        <a href="market-settings.html" class="nav-item" data-page="market-settings">
            <span>💰</span> Pazar Ayarları
        </a>
        <a href="shops.html" class="nav-item" data-page="shops">
            <span>🏪</span> Dükkanlar
        </a>
        <a href="shop-types.html" class="nav-item" data-page="shop-types">
            <span>🛍️</span> Dükkan Çeşitleri
        </a>
        <a href="transactions.html" class="nav-item" data-page="transactions">
            <span>💰</span> İşlemler
        </a>
        <a href="events.html" class="nav-item" data-page="events">
            <span>⚡</span> Olaylar
        </a>
        <a href="economic-dashboard.html" class="nav-item" data-page="economic-dashboard">
            <span>📈</span> Ekonomi
        </a>
        <a href="analytics.html" class="nav-item" data-page="analytics">
            <span>📊</span> Analitik
        </a>
        <a href="banned-words.html" class="nav-item" data-page="banned-words">
            <span>🚫</span> Yasaklı Kelimeler
        </a>
        <hr style="border: none; border-top: 1px solid #374151; margin: 16px 0;">
        <a href="hr.html" class="nav-item" data-page="hr">
            <span>💼</span> İK Yönetimi
        </a>
        <a href="rd.html" class="nav-item" data-page="rd">
            <span>🔬</span> R&D Yönetimi
        </a>
        <a href="holdings.html" class="nav-item" data-page="holdings">
            <span>📈</span> Holdingler
        </a>
        <a href="auctions.html" class="nav-item" data-page="auctions">
            <span>🔨</span> İhaleler
        </a>
        <hr style="border: none; border-top: 1px solid #374151; margin: 16px 0;">
        <a href="global-events.html" class="nav-item" data-page="global-events">
            <span>🌍</span> Global Olaylar
        </a>
        <a href="bank.html" class="nav-item" data-page="bank">
            <span>🏦</span> Banka
        </a>
        <a href="premium.html" class="nav-item" data-page="premium">
            <span>💎</span> Premium
        </a>
    </nav>
    <div class="sidebar-footer">
        <div class="admin-info" id="adminInfo"></div>
        <button onclick="logout()" class="btn-logout">Çıkış Yap</button>
    </div>
</aside>
`;

// Load sidebar into page
function loadSidebar() {
    const container = document.querySelector('.admin-container');
    if (container && !container.querySelector('.sidebar')) {
        container.insertAdjacentHTML('afterbegin', SIDEBAR_HTML);
        setupSidebarNavigation();
        displayAdminInfo();
    }
}

// Setup sidebar navigation
function setupSidebarNavigation() {
    const navItems = document.querySelectorAll('.nav-item');
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    
    navItems.forEach(item => {
        const href = item.getAttribute('href');
        if (href === currentPage || href === '/' + currentPage) {
            item.classList.add('active');
        }
        
        item.addEventListener('click', function(e) {
            navItems.forEach(i => i.classList.remove('active'));
            this.classList.add('active');
        });
    });
}

// Display admin info
function displayAdminInfo() {
    const adminData = localStorage.getItem('adminUser');
    
    if (adminData) {
        try {
            const admin = JSON.parse(adminData);
            const adminInfoEl = document.getElementById('adminInfo');
            if (adminInfoEl) {
                adminInfoEl.innerHTML = `
                    <div style="font-size: 12px; color: #9ca3af;">
                        <p style="margin: 0;">${admin.username}</p>
                        <p style="margin: 0; font-size: 10px;">${admin.role}</p>
                    </div>
                `;
            }
        } catch (e) {
            console.error('Error parsing admin data:', e);
        }
    }
}

// Load sidebar when DOM is ready
document.addEventListener('DOMContentLoaded', loadSidebar);
