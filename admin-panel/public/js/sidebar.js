// Sidebar loader and active page highlighter

function loadSidebar() {
    // Get current page name from URL
    const currentPath = window.location.pathname;
    const currentPage = currentPath.split('/').pop().replace('.html', '') || 'index';

    // Fetch and inject sidebar HTML
    fetch('/sidebar.html')
        .then(response => {
            if (!response.ok) {
                throw new Error('Sidebar HTML not found');
            }
            return response.text();
        })
        .then(html => {
            // Find sidebar container or create one
            let container = document.querySelector('.admin-container');
            if (!container) {
                // If no container, create one and wrap main content
                const body = document.body;
                container = document.createElement('div');
                container.className = 'admin-container';

                // Move all body children to container
                while (body.firstChild) {
                    container.appendChild(body.firstChild);
                }

                body.appendChild(container);
            }

            // Insert sidebar at the beginning of container
            container.insertAdjacentHTML('afterbegin', html);

            // Highlight active menu item
            highlightActiveMenuItem(currentPage);
        })
        .catch(error => {
            console.error('Failed to load sidebar:', error);
        });
}

function highlightActiveMenuItem(currentPage) {
    // Remove all active classes
    document.querySelectorAll('.nav-item').forEach(item => {
        item.classList.remove('active');
    });

    // Add active class to current page
    const activeItem = document.querySelector(`.nav-item[data-page="${currentPage}"]`);
    if (activeItem) {
        activeItem.classList.add('active');
    } else {
        // Fallback: if no match, try to match by href
        const currentPath = window.location.pathname;
        document.querySelectorAll('.nav-item').forEach(item => {
            const href = item.getAttribute('href');
            if (currentPath.includes(href) || (currentPath === '/' && href === '/index.html')) {
                item.classList.add('active');
            }
        });
    }
}

// Auto-load sidebar when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadSidebar);
} else {
    loadSidebar();
}
