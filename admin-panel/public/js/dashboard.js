// Dashboard page logic
let dashboardData = null;

async function loadDashboard() {
    try {
        const data = await getDashboard();
        
        if (data && data.success) {
            dashboardData = data.data;
            updateStats();
            updateTopPlayers();
            updateLastUpdate();
        }
    } catch (error) {
        console.error('Dashboard load error:', error);
    }
}

function updateStats() {
    if (!dashboardData) return;
    
    // Update stat cards
    document.getElementById('totalPlayers').textContent = formatNumber(dashboardData.players.total);
    document.getElementById('activePlayers').textContent = formatNumber(dashboardData.players.active);
    document.getElementById('bannedPlayers').textContent = formatNumber(dashboardData.players.banned);
    document.getElementById('totalProducts').textContent = formatNumber(dashboardData.products.total);
    document.getElementById('totalShops').textContent = formatNumber(dashboardData.shops.total);
    document.getElementById('rentedShops').textContent = formatNumber(dashboardData.shops.rented);
    document.getElementById('totalTransactions').textContent = formatNumber(dashboardData.transactions.total);
    document.getElementById('todayTransactions').textContent = formatNumber(dashboardData.transactions.today);
}

function updateTopPlayers() {
    if (!dashboardData || !dashboardData.topPlayers) return;
    
    const tbody = document.getElementById('topPlayersTable');
    
    if (dashboardData.topPlayers.length === 0) {
        tbody.innerHTML = '<tr><td colspan="4" class="loading">Henüz oyuncu yok</td></tr>';
        return;
    }
    
    tbody.innerHTML = dashboardData.topPlayers.map((player, index) => `
        <tr>
            <td><strong>${index + 1}</strong></td>
            <td>${player.username}</td>
            <td><span class="badge badge-info">Lvl ${player.level}</span></td>
            <td>${formatCurrency(player.totalProfit)}</td>
        </tr>
    `).join('');
}

async function loadRecentTransactions() {
    try {
        // Bu endpoint henüz yok, ama eklenebilir
        // Şimdilik boş gösterelim
        const tbody = document.getElementById('recentTransactionsTable');
        tbody.innerHTML = '<tr><td colspan="5" class="loading">İşlem geçmişi için oyuncu detay sayfasını ziyaret edin</td></tr>';
    } catch (error) {
        console.error('Transactions load error:', error);
    }
}

async function loadActiveEvents() {
    try {
        // Bu endpoint henüz yok, ama eklenebilir
        const tbody = document.getElementById('activeEventsTable');
        tbody.innerHTML = '<tr><td colspan="5" class="loading">Aktif olay yok</td></tr>';
    } catch (error) {
        console.error('Events load error:', error);
    }
}

function updateLastUpdate() {
    const now = new Date();
    document.getElementById('lastUpdate').textContent = `Son güncelleme: ${formatDate(now)}`;
}

async function refreshData() {
    await loadDashboard();
    await loadRecentTransactions();
    await loadActiveEvents();
}

// Auto refresh every 30 seconds
setInterval(refreshData, 30000);

// Initial load
document.addEventListener('DOMContentLoaded', () => {
    refreshData();
});
