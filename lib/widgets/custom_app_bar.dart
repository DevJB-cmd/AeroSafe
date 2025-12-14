import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// ================================
/// AppBar Variants
/// ================================
enum CustomAppBarVariant {
  standard,
  compact,
  withBack,
  withSearch,
  transparent,
  admin,
}

/// ================================
/// Custom App Bar
/// ================================
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;

  final CustomAppBarVariant variant;

  final Widget? leading;
  final List<Widget>? actions;

  final bool centerTitle;
  final bool automaticallyImplyLeading;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final bool showElevation;

  /// Search
  final ValueChanged<String>? onSearch;

  /// Role / admin
  final bool showRoleBadge;
  final String? roleType;

  /// Optional bottom (TabBar, etc.)
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.variant = CustomAppBarVariant.standard,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.showElevation = true,
    this.onSearch,
    this.showRoleBadge = false,
    this.roleType,
    this.bottom,
  });

  @override
  Size get preferredSize {
    final double baseHeight =
        variant == CustomAppBarVariant.compact ? 56 : 64;
    final double extra =
        subtitle != null && variant == CustomAppBarVariant.admin ? 16 : 0;
    final double bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(baseHeight + extra + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case CustomAppBarVariant.withSearch:
        return _buildSearchAppBar(context, theme, colorScheme);
      case CustomAppBarVariant.transparent:
        return _buildTransparentAppBar(context, theme, colorScheme);
      case CustomAppBarVariant.admin:
        return _buildAdminAppBar(context, theme, colorScheme);
      default:
        return _buildStandardAppBar(context, theme, colorScheme);
    }
  }

  /// ================================
  /// STANDARD / COMPACT / WITH BACK
  /// ================================
  Widget _buildStandardAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: foregroundColor ?? colorScheme.onPrimary,
      elevation: showElevation ? 2 : 0,
      centerTitle: centerTitle,
      leading: _buildLeading(context),
      title: _buildTitle(theme, foregroundColor ?? colorScheme.onPrimary),
      actions: actions,
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  /// ================================
  /// SEARCH
  /// ================================
  Widget _buildSearchAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: showElevation ? 2 : 0,
      centerTitle: false,
      leading: _buildLeading(context),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          onChanged: onSearch,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onPrimary),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimary.withValues(alpha: 0.7),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: colorScheme.onPrimary.withValues(alpha: 0.7),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  /// ================================
  /// TRANSPARENT
  /// ================================
  Widget _buildTransparentAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle,
      leading: _buildLeading(context),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _buildTitle(theme, colorScheme.onSurface),
      ),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  /// ================================
  /// ADMIN
  /// ================================
  Widget _buildAdminAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: showElevation ? 2 : 0,
      centerTitle: centerTitle,
      leading: _buildLeading(context),
      title: Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorScheme.onPrimary,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: colorScheme.onPrimary.withValues(alpha: 0.8),
              ),
            ),
        ],
      ),
      actions: [
        _buildAdminBadge(theme),
        if (actions != null) ...actions!,
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  /// ================================
  /// HELPERS
  /// ================================
  Widget _buildTitle(ThemeData theme, Color color) {
    if (subtitle != null && variant != CustomAppBarVariant.admin) {
      return Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: color.withValues(alpha: 0.7),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        if (showRoleBadge && roleType != null) ...[
          const SizedBox(width: 8),
          _buildRoleBadge(theme),
        ],
      ],
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (variant == CustomAppBarVariant.withBack ||
        automaticallyImplyLeading &&
            (ModalRoute.of(context)?.canPop ?? false)) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).pop();
        },
      );
    }
    return null;
  }

  Widget _buildRoleBadge(ThemeData theme) {
    final scheme = theme.colorScheme;
    final isAdmin = roleType?.toLowerCase() == 'admin';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isAdmin ? scheme.secondary : scheme.primary)
            .withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isAdmin ? scheme.secondary : scheme.primary,
        ),
      ),
      child: Text(
        roleType!.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isAdmin ? scheme.secondary : scheme.primary,
        ),
      ),
    );
  }

  Widget _buildAdminBadge(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF00D95A).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00D95A)),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 4, backgroundColor: Color(0xFF00D95A)),
          const SizedBox(width: 6),
          Text(
            'ADMIN',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
