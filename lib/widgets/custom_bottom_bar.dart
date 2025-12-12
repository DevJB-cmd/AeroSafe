import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom bottom navigation bar for aviation safety application
/// Implements bottom-heavy thumb zone strategy with haptic feedback
/// Supports role-based navigation with secure admin access
class CustomBottomBar extends StatefulWidget {
  /// Current selected index
  final int currentIndex;

  /// Callback when navigation item is tapped
  final Function(int) onTap;

  /// Whether to show admin tab (requires authentication)
  final bool showAdminTab;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showAdminTab = false,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void didUpdateWidget(CustomBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap(int index) {
    // Haptic feedback for tab switching
    HapticFeedback.lightImpact();
    widget.onTap(index);
  }

  List<_NavigationItem> _getNavigationItems() {
    final items = <_NavigationItem>[
      _NavigationItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: 'Home',
        route: '/home-screen',
      ),
      _NavigationItem(
        icon: Icons.report_outlined,
        activeIcon: Icons.report,
        label: 'Report',
        route: '/incident-selection',
      ),
      if (widget.showAdminTab)
        _NavigationItem(
          icon: Icons.admin_panel_settings_outlined,
          activeIcon: Icons.admin_panel_settings,
          label: 'Admin',
          route: '/admin-authentication',
        ),
      _NavigationItem(
        icon: Icons.map_outlined,
        activeIcon: Icons.map,
        label: 'Map',
        route: '/location-mapping',
      ),
      _NavigationItem(
        icon: Icons.help_outline,
        activeIcon: Icons.help,
        label: 'Help',
        route: '/home-screen', // Help section in home
      ),
    ];
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final navigationItems = _getNavigationItems();

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              navigationItems.length,
              (index) => _buildNavigationItem(
                context,
                navigationItems[index],
                index,
                widget.currentIndex == index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(
    BuildContext context,
    _NavigationItem item,
    int index,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: ScaleTransition(
        scale: isSelected && _previousIndex != index
            ? _scaleAnimation
            : const AlwaysStoppedAnimation(1.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _handleTap(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isSelected ? item.activeIcon : item.icon,
                      size: 24,
                      color: isSelected
                          ? colorScheme.primary
                          : theme.bottomNavigationBarTheme.unselectedItemColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: isSelected
                          ? colorScheme.primary
                          : theme.bottomNavigationBarTheme.unselectedItemColor,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                    ),
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Internal class to represent navigation items
class _NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  _NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}
