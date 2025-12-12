import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom tab bar for aviation safety application
/// Implements horizontal tab navigation with aerospace minimalism
/// Supports various configurations for different content sections
enum CustomTabBarVariant {
  /// Standard tab bar with equal width tabs
  standard,

  /// Scrollable tab bar for many tabs
  scrollable,

  /// Tab bar with icons and labels
  withIcons,

  /// Compact tab bar with smaller padding
  compact,
}

class CustomTabBar extends StatelessWidget {
  /// List of tab labels
  final List<String> tabs;

  /// Optional list of icons (must match tabs length if provided)
  final List<IconData>? icons;

  /// Variant of the tab bar
  final CustomTabBarVariant variant;

  /// Tab controller for managing tab state
  final TabController controller;

  /// Callback when tab is tapped
  final Function(int)? onTap;

  /// Whether to show indicator
  final bool showIndicator;

  /// Custom indicator color
  final Color? indicatorColor;

  /// Custom indicator weight
  final double indicatorWeight;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    this.icons,
    this.variant = CustomTabBarVariant.standard,
    this.onTap,
    this.showIndicator = true,
    this.indicatorColor,
    this.indicatorWeight = 3.0,
  }) : assert(
          icons == null || icons.length == tabs.length,
          'Icons list must match tabs length',
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case CustomTabBarVariant.standard:
        return _buildStandardTabBar(context, theme, colorScheme);
      case CustomTabBarVariant.scrollable:
        return _buildScrollableTabBar(context, theme, colorScheme);
      case CustomTabBarVariant.withIcons:
        return _buildWithIconsTabBar(context, theme, colorScheme);
      case CustomTabBarVariant.compact:
        return _buildCompactTabBar(context, theme, colorScheme);
    }
  }

  Widget _buildStandardTabBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        tabs: tabs
            .map((tab) => Tab(
                  height: 48,
                  child: Text(tab),
                ))
            .toList(),
        onTap: (index) {
          HapticFeedback.lightImpact();
          onTap?.call(index);
        },
        labelColor: colorScheme.primary,
        unselectedLabelColor: theme.tabBarTheme.unselectedLabelColor,
        labelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        indicator: showIndicator
            ? UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: indicatorColor ?? const Color(0xFF00C6FF),
                  width: indicatorWeight,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 16),
              )
            : null,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildScrollableTabBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: tabs
            .map((tab) => Tab(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(tab),
                  ),
                ))
            .toList(),
        onTap: (index) {
          HapticFeedback.lightImpact();
          onTap?.call(index);
        },
        labelColor: colorScheme.primary,
        unselectedLabelColor: theme.tabBarTheme.unselectedLabelColor,
        labelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        indicator: showIndicator
            ? UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: indicatorColor ?? const Color(0xFF00C6FF),
                  width: indicatorWeight,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 8),
              )
            : null,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildWithIconsTabBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    assert(icons != null, 'Icons must be provided for withIcons variant');

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        tabs: List.generate(
          tabs.length,
          (index) => Tab(
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icons![index],
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(tabs[index]),
              ],
            ),
          ),
        ),
        onTap: (index) {
          HapticFeedback.lightImpact();
          onTap?.call(index);
        },
        labelColor: colorScheme.primary,
        unselectedLabelColor: theme.tabBarTheme.unselectedLabelColor,
        labelStyle: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        indicator: showIndicator
            ? UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: indicatorColor ?? const Color(0xFF00C6FF),
                  width: indicatorWeight,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 16),
              )
            : null,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildCompactTabBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        tabs: tabs
            .map((tab) => Tab(
                  height: 40,
                  child: Text(tab),
                ))
            .toList(),
        onTap: (index) {
          HapticFeedback.lightImpact();
          onTap?.call(index);
        },
        labelColor: colorScheme.primary,
        unselectedLabelColor: theme.tabBarTheme.unselectedLabelColor,
        labelStyle: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        indicator: showIndicator
            ? UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: indicatorColor ?? const Color(0xFF00C6FF),
                  width: indicatorWeight,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 12),
              )
            : null,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}

/// Custom tab bar with pill-style selection indicator
/// Alternative design for content filtering and categorization
class CustomPillTabBar extends StatelessWidget {
  /// List of tab labels
  final List<String> tabs;

  /// Currently selected tab index
  final int selectedIndex;

  /// Callback when tab is tapped
  final Function(int) onTap;

  /// Whether tabs should be scrollable
  final bool isScrollable;

  const CustomPillTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isScrollable
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) =>
                  _buildPillTab(context, theme, colorScheme, index),
            )
          : Row(
              children: List.generate(
                tabs.length,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index > 0 ? 4 : 0,
                      right: index < tabs.length - 1 ? 4 : 0,
                    ),
                    child: _buildPillTab(context, theme, colorScheme, index),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildPillTab(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    int index,
  ) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            tabs[index],
            style: theme.textTheme.labelMedium?.copyWith(
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
