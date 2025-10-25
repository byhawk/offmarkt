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

        if (response.status === 401) {
            logout();
            return null;
        }

        if (!response.ok) {
            console.error(`API Error: ${response.status} ${response.statusText}`);
            const errorData = await response.json().catch(() => ({ message: 'Unknown error' }));
            console.error('Error details:', errorData);
            return null;
        }

        const data = await response.json();
        return data;
    } catch (error) {
        console.error('API Error:', error);
        console.error('Endpoint:', endpoint);
        console.error('API_URL:', API_URL);
        alert('Bağlantı hatası! Backend çalışıyor mu?\n\nDetay: ' + error.message);
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

// Global Events API
async function getGlobalEvents(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/global-events?${query}`);
}

async function createGlobalEvent(data) {
    return await apiRequest('/global-events', {
        method: 'POST',
        body: JSON.stringify(data)
    });
}

async function triggerGlobalEvent(eventId) {
    return await apiRequest(`/global-events/${eventId}/trigger`, {
        method: 'POST'
    });
}

async function updateGlobalEvent(id, data) {
    return await apiRequest(`/global-events/${id}`, {
        method: 'PUT',
        body: JSON.stringify(data)
    });
}

async function deleteGlobalEvent(id) {
    return await apiRequest(`/global-events/${id}`, {
        method: 'DELETE'
    });
}

// Bank API
async function getBankAccounts(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/bank/accounts?${query}`);
}

async function getBankAccount(playerId) {
    return await apiRequest(`/bank/account/${playerId}`);
}

async function getBankTransactions(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/bank/transactions?${query}`);
}

async function calculateBankInterest() {
    return await apiRequest('/bank/calculate-interest', {
        method: 'POST'
    });
}

// Premium API
async function getPremiumCurrencies(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/premium/currencies?${query}`);
}

async function getPremiumBoosts(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/premium/boosts?${query}`);
}

async function createPremiumBoost(data) {
    return await apiRequest('/premium/boosts', {
        method: 'POST',
        body: JSON.stringify(data)
    });
}

async function updatePremiumBoost(id, data) {
    return await apiRequest(`/premium/boosts/${id}`, {
        method: 'PUT',
        body: JSON.stringify(data)
    });
}

async function deletePremiumBoost(id) {
    return await apiRequest(`/premium/boosts/${id}`, {
        method: 'DELETE'
    });
}

async function getPremiumTransactions(params = {}) {
    const query = new URLSearchParams(params).toString();
    return await apiRequest(`/premium/transactions?${query}`);
}

// Upload API
async function uploadImage(file, type = 'general') {
    const token = getToken();
    const formData = new FormData();
    formData.append('image', file);
    formData.append('type', type);
    
    try {
        const response = await fetch(`http://213.142.159.245:3000/api/admin/upload`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`
            },
            body: formData
        });
        
        const data = await response.json();
        
        if (response.status === 401) {
            logout();
            return null;
        }
        
        return data;
    } catch (error) {
        console.error('Upload Error:', error);
        alert('Resim yükleme hatası!');
        return null;
    }
}

async function updateProductImage(productId, imageUrl) {
    return await apiRequest(`/products/${productId}/image`, {
        method: 'PUT',
        body: JSON.stringify({ imageUrl })
    });
}

async function updateShopImage(shopId, imageUrl) {
    return await apiRequest(`/shops/${shopId}/image`, {
        method: 'PUT',
        body: JSON.stringify({ imageUrl })
    });
}

async function updateShopTypeImage(shopTypeId, imageUrl) {
    return await apiRequest(`/shop-types/${shopTypeId}/image`, {
        method: 'PUT',
        body: JSON.stringify({ imageUrl })
    });
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

// Export API wrapper object for global access
const API = {
    call: apiRequest,
    get: (endpoint) => apiRequest(endpoint),
    post: (endpoint, body) => apiRequest(endpoint, { method: 'POST', body: JSON.stringify(body) }),
    put: (endpoint, body) => apiRequest(endpoint, { method: 'PUT', body: JSON.stringify(body) }),
    delete: (endpoint) => apiRequest(endpoint, { method: 'DELETE' })
};

// Make API available globally for HTML files
window.API = API;
