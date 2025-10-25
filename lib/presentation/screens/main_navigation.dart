import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'home/home_screen.dart';
import 'inventory/inventory_screen.dart';
import 'shops/shops_screen.dart';
import 'business/business_screen.dart';
import 'holding/holding_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    InventoryScreen(),
    ShopsScreen(),
    BusinessScreen(),
    HoldingScreen(),
  ];

  final List<NavigationItem> _navItems = const [
    NavigationItem(icon: Icons.home, label: 'Ana Sayfa', emoji: '🏠'),
    NavigationItem(icon: Icons.inventory, label: 'Envanter', emoji: '📦'),
    NavigationItem(icon: Icons.apartment, label: 'Dükkanlar', emoji: '🏢'),
    NavigationItem(icon: Icons.business_center, label: 'İşletme', emoji: '💼'),
    NavigationItem(icon: Icons.corporate_fare, label: 'Holding', emoji: '🏛️'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _screens),
        bottomNavigationBar: _selectedIndex < 3 ? _buildBottomNav() : null,
        bottomSheet: _selectedIndex >= 2 ? _buildExtendedNav() : null,
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundCard,
            AppColors.backgroundCard.withValues(alpha: 0.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.accentGold,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: _navItems.take(5).map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExtendedNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundCard,
            AppColors.backgroundCard.withValues(alpha: 0.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) {
          final item = _navItems[index];
          final isSelected = _selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => _onItemTapped(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected ? AppColors.primary : Colors.grey,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? AppColors.primary : Colors.grey,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String emoji;

  const NavigationItem({
    required this.icon,
    required this.label,
    required this.emoji,
  });
}
