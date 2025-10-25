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

// Global Events API - Detached (Non-admin) endpoints, need separate base URL
const GLOBAL_EVENTS_URL = 'http://213.142.159.245:3000/api/global-events';

async function getGlobalEvents(params = {}) {
    const query = new URLSearchParams(params).toString();
    const token = getToken();
    try {
        const response = await fetch(`${GLOBAL_EVENTS_URL}?${query}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Global Events Error:', error);
        return null;
    }
}

async function createGlobalEvent(data) {
    const token = getToken();
    try {
        const response = await fetch(`${GLOBAL_EVENTS_URL}/create`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Create Global Event Error:', error);
        return null;
    }
}

async function triggerGlobalEvent(eventId) {
    const token = getToken();
    try {
        const response = await fetch(`${GLOBAL_EVENTS_URL}/${eventId}/trigger`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Trigger Global Event Error:', error);
        return null;
    }
}

async function updateGlobalEvent(id, data) {
    const token = getToken();
    try {
        const response = await fetch(`${GLOBAL_EVENTS_URL}/${id}`, {
            method: 'PUT',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Update Global Event Error:', error);
        return null;
    }
}

async function deleteGlobalEvent(id) {
    const token = getToken();
    try {
        const response = await fetch(`${GLOBAL_EVENTS_URL}/${id}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Delete Global Event Error:', error);
        return null;
    }
}

// Bank API - Separate endpoint
const BANK_URL = 'http://213.142.159.245:3000/api/bank';

async function getBankAccounts(params = {}) {
    const query = new URLSearchParams(params).toString();
    const token = getToken();
    try {
        const response = await fetch(`${BANK_URL}/accounts?${query}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Bank Accounts Error:', error);
        return null;
    }
}

async function getBankAccount(playerId) {
    const token = getToken();
    try {
        const response = await fetch(`${BANK_URL}/account/${playerId}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Bank Account Error:', error);
        return null;
    }
}

async function getBankTransactions(params = {}) {
    const query = new URLSearchParams(params).toString();
    const token = getToken();
    try {
        const response = await fetch(`${BANK_URL}/transactions?${query}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Bank Transactions Error:', error);
        return null;
    }
}

async function calculateBankInterest() {
    const token = getToken();
    try {
        const response = await fetch(`${BANK_URL}/calculate-interest`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Calculate Interest Error:', error);
        return null;
    }
}

// Premium API - Separate endpoint
const PREMIUM_URL = 'http://213.142.159.245:3000/api/premium';

async function getPremiumCurrencies(params = {}) {
    const query = new URLSearchParams(params).toString();
    const token = getToken();
    try {
        const response = await fetch(`${PREMIUM_URL}/currencies?${query}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Premium Currencies Error:', error);
        return null;
    }
}

async function getPremiumBoosts(params = {}) {
    const query = new URLSearchParams(params).toString();
    const token = getToken();
    try {
        const response = await fetch(`${PREMIUM_URL}/boosts?${query}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Premium Boosts Error:', error);
        return null;
    }
}

async function createPremiumBoost(data) {
    const token = getToken();
    try {
        const response = await fetch(`${PREMIUM_URL}/boosts`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Create Premium Boost Error:', error);
        return null;
    }
}

async function updatePremiumBoost(id, data) {
    const token = getToken();
    try {
        const response = await fetch(`${PREMIUM_URL}/boosts/${id}`, {
            method: 'PUT',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Update Premium Boost Error:', error);
        return null;
    }
}

async function deletePremiumBoost(id) {
    const token = getToken();
    try {
        const response = await fetch(`${PREMIUM_URL}/boosts/${id}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Delete Premium Boost Error:', error);
        return null;
    }
}

async function getPremiumTransactions(params = {}) {
    const query = new URLSearchParams(params).toString();
    const token = getToken();
    try {
        const response = await fetch(`${PREMIUM_URL}/transactions?${query}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) return null;
        return await response.json();
    } catch (error) {
        console.error('Premium Transactions Error:', error);
        return null;
    }
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
