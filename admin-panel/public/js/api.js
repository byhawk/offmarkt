const API_URL = 'http://213.142.159.245:3000/api/admin';

// Generic API request function
async function apiRequest(endpoint, options = {}) {
    const token = getToken();
    
    const config = {
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
        },
        ...options
    };
    
    try {
        const response = await fetch(`${API_URL}${endpoint}`, config);
        const data = await response.json();
        
        if (response.status === 401) {
            logout();
            return null;
        }
        
        return data;
    } catch (error) {
        console.error('API Error:', error);
        alert('Bağlantı hatası! Backend çalışıyor mu?');
        return null;
    }
}

// Dashboard API
async function getDashboard() {
    return await apiRequest('/dashboard');
}

// Players API
async function getPlayers(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/players?${query}`);
}

async function getPlayer(id) {
    return await apiRequest(`/players/${id}`);
}

async function banPlayer(id, reason, duration) {
    return await apiRequest(`/players/${id}/ban`, {
        method: 'PUT',
        body: JSON.stringify({ reason, duration })
    });
}

async function unbanPlayer(id) {
    return await apiRequest(`/players/${id}/unban`, {
        method: 'PUT'
    });
}

async function resetPlayerPassword(id, newPassword) {
    return await apiRequest(`/players/${id}/reset-password`, {
        method: 'PUT',
        body: JSON.stringify({ newPassword })
    });
}

// Products API
async function getProducts() {
    return await apiRequest('/products');
}

async function createProduct(data) {
    return await apiRequest('/products', {
        method: 'POST',
        body: JSON.stringify(data)
    });
}

async function updateProduct(id, data) {
    return await apiRequest(`/products/${id}`, {
        method: 'PUT',
        body: JSON.stringify(data)
    });
}

async function deleteProduct(id) {
    return await apiRequest(`/products/${id}`, {
        method: 'DELETE'
    });
}

async function toggleProductActive(id) {
    return await apiRequest(`/products/${id}/toggle-active`, {
        method: 'PUT'
    });
}

// Shops API
async function getShops() {
    return await apiRequest('/shops');
}

async function createShop(data) {
    return await apiRequest('/shops', {
        method: 'POST',
        body: JSON.stringify(data)
    });
}

async function updateShop(id, data) {
    return await apiRequest(`/shops/${id}`, {
        method: 'PUT',
        body: JSON.stringify(data)
    });
}

// Events API
async function triggerEvent(playerId) {
    return await apiRequest('/events/trigger', {
        method: 'POST',
        body: JSON.stringify({ playerId })
    });
}

// Stats API
async function getStats(days = 7) {
    return await apiRequest(`/stats?days=${days}`);
}

// Banned Words API
async function getBannedWords(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/banned-words?${query}`);
}

async function addBannedWord(data) {
    return await apiRequest('/banned-words', {
        method: 'POST',
        body: JSON.stringify(data)
    });
}

async function addBannedWordsBulk(words) {
    return await apiRequest('/banned-words/bulk', {
        method: 'POST',
        body: JSON.stringify({ words })
    });
}

async function updateBannedWord(id, data) {
    return await apiRequest(`/banned-words/${id}`, {
        method: 'PUT',
        body: JSON.stringify(data)
    });
}

async function deleteBannedWord(id) {
    return await apiRequest(`/banned-words/${id}`, {
        method: 'DELETE'
    });
}

async function checkText(text) {
    return await apiRequest('/banned-words/check', {
        method: 'POST',
        body: JSON.stringify({ text })
    });
}

// Transactions API
async function getTransactions(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/transactions?${query}`);
}

// Events API
async function getEvents(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/events?${query}`);
}

// Utility functions
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleString('tr-TR');
}

function formatCurrency(amount) {
    return new Intl.NumberFormat('tr-TR', {
        style: 'currency',
        currency: 'TRY'
    }).format(amount);
}

function formatNumber(num) {
    return new Intl.NumberFormat('tr-TR').format(num);
}
