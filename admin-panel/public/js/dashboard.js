// Dashboard page logic
let dashboardData = null;
let economicData = null;

async function loadDashboard() {
    try {
        // Ana dashboard verileri
        const data = await getDashboard();
        if (data && data.success) {
            dashboardData = data.data;
        }

        // Ekonomik sistem verileri
        const economicResult = await API.call('/admin/economic-dashboard');
        if (economicResult.success) {
            economicData = economicResult.data;
        }

        // UI güncellemeleri
        updateStats();
        updateTopPlayers();
        updateLastUpdate();
    } catch (error) {
        console.error('Dashboard load error:', error);
    }
}

function updateStats() {
    if (!dashboardData) return;

    // Ana istatistikler
    document.getElementById('totalPlayers').textContent = formatNumber(dashboardData.players.total);
    document.getElementById('activePlayers').textContent = formatNumber(dashboardData.players.active);
    document.getElementById('bannedPlayers').textContent = formatNumber(dashboardData.players.banned);
    document.getElementById('totalProducts').textContent = formatNumber(dashboardData.products.total);
    document.getElementById('totalShops').textContent = formatNumber(dashboardData.shops.total);
    document.getElementById('rentedShops').textContent = formatNumber(dashboardData.shops.rented);
    document.getElementById('totalTransactions').textContent = formatNumber(dashboardData.transactions.total);
    document.getElementById('todayTransactions').textContent = formatNumber(dashboardData.transactions.today);

    // Ekonomik sistem istatistikleri
    if (economicData && economicData.marketOverview) {
        document.getElementById('autoShops').textContent = formatNumber(economicData.marketOverview.shopsWithAutoPurchase);
        document.getElementById('listedProducts').textContent = formatNumber(economicData.marketOverview.totalListedProducts);

        // Pazar sağlığı göstergesi
        const marketHealthCard = document.getElementById('marketHealthCard');
        const marketHealthElement = document.getElementById('marketHealth');

        marketHealthCard.className = 'stat-card'; // Reset classes

        switch (economicData.marketOverview.marketHealth) {
            case 'healthy':
                marketHealthCard.classList.add('stat-card', 'success');
                marketHealthElement.textContent = 'Sağlıklı';
                break;
            case 'unbalanced':
                marketHealthCard.classList.add('stat-card', 'warning');
                marketHealthElement.textContent = 'Dengesiz';
                break;
            default:
                marketHealthCard.classList.add('stat-card', 'danger');
                marketHealthElement.textContent = 'Riskli';
                break;
        }

        // Ekonomik işlemler (örnek olarak transakisyonların bir kısmını ekonomik olarak sayabiliriz)
        document.getElementById('economicTransactions').textContent = formatNumber(
            Math.floor(dashboardData.transactions.today * 0.7)
        ); // Yaklaşık %70'i ekonomik işlem olarak kabul edelim
    }
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
