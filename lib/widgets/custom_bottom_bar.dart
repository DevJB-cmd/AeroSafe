import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// ================================
/// Navigation item configuration
/// ================================
class CustomBottomBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final bool showBadge;
  final String? badgeText;

  const CustomBottomBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    this.showBadge = false,
    this.badgeText,
  });
}

/// ================================
/// Variants
/// ================================
enum CustomBottomBarVariant {
  standard,
  compact,
}

/// ================================
/// Custom Bottom Bar
/// ================================
class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  /// Admin / role options
  final bool showAdminTab;
  final bool showRoleBadge;
  final String? roleType;

  final CustomBottomBarVariant variant;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.showAdminTab = false,
    this.showRoleBadge = false,
    this.roleType,
    this.variant = CustomBottomBarVariant.standard,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _lastTappedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// ================================
  /// Navigation items (fusion logique)
  /// ================================
  List<CustomBottomBarItem> get _items => [
        const CustomBottomBarItem(
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
          label: 'Home',
          route: '/home-screen',
        ),
        const CustomBottomBarItem(
          icon: Icons.report_outlined,
          activeIcon: Icons.report,
          label: 'Report',
          route: '/incident-selection',
        ),
        if (widget.showAdminTab)
          const CustomBottomBarItem(
            icon: Icons.admin_panel_settings_outlined,
            activeIcon: Icons.admin_panel_settings,
            label: 'Admin',
            route: '/admin-dashboard-screen',
          ),
        const CustomBottomBarItem(
          icon: Icons.map_outlined,
          activeIcon: Icons.map,
          label: 'Map',
          route: '/location-mapping',
        ),
        const CustomBottomBarItem(
          icon: Icons.settings_outlined,
          activeIcon: Icons.settings,
          label: 'Settings',
          route: '/settings-screen',
        ),
      ];

  void _handleTap(int index) {
    if (index == widget.currentIndex) return;

    HapticFeedback.lightImpact();

    setState(() => _lastTappedIndex = index);
    _controller.forward().then((_) => _controller.reverse());

    if (widget.onTap != null) {
      widget.onTap!(index);
    } else {
      Navigator.pushNamed(context, _items[index].route);
    }
  }

  Widget _buildItem(CustomBottomBarItem item, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = widget.currentIndex == index;

    final color = isSelected
        ? colorScheme.primary
        : theme.bottomNavigationBarTheme.unselectedItemColor ??
            colorScheme.onSurface.withValues(alpha: 0.6);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleTap(index),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (_, child) {
              return Transform.scale(
                scale: _lastTappedIndex == index
                    ? _scaleAnimation.value
                    : 1.0,
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        isSelected ? item.activeIcon : item.icon,
                        size: 24,
                        color: color,
                      ),
                      if (item.showBadge ||
                          (widget.showRoleBadge && index == 0))
                        Positioned(
                          right: -8,
                          top: -4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: item.badgeText != null
                                ? Text(
                                    item.badgeText!,
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: colorScheme.onSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height:
              widget.variant == CustomBottomBarVariant.compact ? 64 : 72,
          child: Row(
            children: List.generate(
              _items.length,
              (i) => _buildItem(_items[i], i),
            ),
          ),
        ),
      ),
    );
  }
}
