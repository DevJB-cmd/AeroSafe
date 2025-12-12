import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom app bar for aviation safety application
/// Implements aerospace minimalism with clean geometry and institutional trust
/// Supports various configurations for different screen contexts
enum CustomAppBarVariant {
  /// Standard app bar with title and optional actions
  standard,

  /// App bar with back button for navigation stack
  withBack,

  /// App bar with search functionality
  withSearch,

  /// Transparent app bar for overlay contexts
  transparent,

  /// App bar for admin dashboard with status indicators
  admin,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title text displayed in the app bar
  final String title;

  /// Variant of the app bar
  final CustomAppBarVariant variant;

  /// Optional leading widget (overrides default back button)
  final Widget? leading;

  /// Optional actions displayed on the right side
  final List<Widget>? actions;

  /// Callback for search functionality
  final Function(String)? onSearch;

  /// Whether to show elevation shadow
  final bool showElevation;

  /// Optional subtitle for additional context
  final String? subtitle;

  /// Whether to center the title
  final bool centerTitle;

  /// Custom background color (overrides theme)
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.variant = CustomAppBarVariant.standard,
    this.leading,
    this.actions,
    this.onSearch,
    this.showElevation = true,
    this.subtitle,
    this.centerTitle = true,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        subtitle != null ? 72.0 : 56.0,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case CustomAppBarVariant.standard:
        return _buildStandardAppBar(context, theme, colorScheme);
      case CustomAppBarVariant.withBack:
        return _buildWithBackAppBar(context, theme, colorScheme);
      case CustomAppBarVariant.withSearch:
        return _buildWithSearchAppBar(context, theme, colorScheme);
      case CustomAppBarVariant.transparent:
        return _buildTransparentAppBar(context, theme, colorScheme);
      case CustomAppBarVariant.admin:
        return _buildAdminAppBar(context, theme, colorScheme);
    }
  }

  Widget _buildStandardAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: showElevation ? 2.0 : 0,
      centerTitle: centerTitle,
      leading: leading,
      title: _buildTitle(theme, colorScheme.onPrimary),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildWithBackAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: showElevation ? 2.0 : 0,
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            tooltip: 'Back',
          ),
      title: _buildTitle(theme, colorScheme.onPrimary),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildWithSearchAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: showElevation ? 2.0 : 0,
      centerTitle: false,
      leading: leading,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          onChanged: onSearch,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Search incidents...',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimary.withValues(alpha: 0.7),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: colorScheme.onPrimary.withValues(alpha: 0.7),
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
      ),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildTransparentAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: colorScheme.onSurface,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            tooltip: 'Back',
          ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _buildTitle(theme, colorScheme.onSurface),
      ),
      actions: actions
          ?.map((action) => Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: action,
              ))
          .toList(),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Widget _buildAdminAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: showElevation ? 2.0 : 0,
      centerTitle: centerTitle,
      leading: leading,
      title: Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimary.withValues(alpha: 0.8),
              ),
            ),
        ],
      ),
      actions: [
        // Status indicator for admin
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF00D95A).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF00D95A),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF00D95A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'ADMIN',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        if (actions != null) ...actions!,
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildTitle(ThemeData theme, Color textColor) {
    if (subtitle != null) {
      return Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: textColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      );
    }
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
