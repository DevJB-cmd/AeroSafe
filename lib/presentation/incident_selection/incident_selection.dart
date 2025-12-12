import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/anonymity_reminder_widget.dart';
import './widgets/incident_category_card.dart';
import './widgets/progress_indicator_widget.dart';

/// Incident Selection Screen - Step 1/3 of progressive disclosure
/// Enables aviation professionals to categorize safety incidents
class IncidentSelection extends StatefulWidget {
  const IncidentSelection({super.key});

  @override
  State<IncidentSelection> createState() => _IncidentSelectionState();
}

class _IncidentSelectionState extends State<IncidentSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String? _selectedCategory;
  bool _isRefreshing = false;

  // Incident categories with aviation-specific data
  final List<Map<String, dynamic>> _incidentCategories = [
    {
      'id': 'in_flight',
      'title': 'In-Flight',
      'description':
          'Incidents occurring during flight operations including turbulence, system malfunctions, or crew coordination issues',
      'icon': 'flight',
      'priority': 'high',
      'color': const Color(0xFFFF4757),
    },
    {
      'id': 'runway',
      'title': 'Runway',
      'description':
          'Runway incursions, excursions, foreign object debris (FOD), or surface condition issues',
      'icon': 'airplanemode_active',
      'priority': 'critical',
      'color': const Color(0xFFFF4757),
    },
    {
      'id': 'baggage_equipment',
      'title': 'Baggage/Equipment',
      'description':
          'Baggage handling errors, equipment damage, loading issues, or cargo security concerns',
      'icon': 'luggage',
      'priority': 'medium',
      'color': const Color(0xFFFFB347),
    },
    {
      'id': 'behavior',
      'title': 'Behavior',
      'description':
          'Unruly passengers, security threats, crew conflicts, or workplace safety violations',
      'icon': 'person_alert',
      'priority': 'high',
      'color': const Color(0xFFFF4757),
    },
    {
      'id': 'material',
      'title': 'Material',
      'description':
          'Aircraft component failures, maintenance issues, hazardous materials, or infrastructure damage',
      'icon': 'build',
      'priority': 'high',
      'color': const Color(0xFFFF4757),
    },
    {
      'id': 'other',
      'title': 'Other',
      'description':
          'Any safety concern not covered by standard categories including environmental or operational issues',
      'icon': 'more_horiz',
      'priority': 'low',
      'color': const Color(0xFFA0AEC0),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    // Simulate category data refresh
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isRefreshing = false);
    if (mounted) {
      HapticFeedback.lightImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Category definitions updated',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _handleCategorySelection(String categoryId) {
    HapticFeedback.mediumImpact();
    setState(() => _selectedCategory = categoryId);

    // Animate selection and navigate
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        Navigator.pushNamed(
          context,
          '/location-mapping',
          arguments: {'categoryId': categoryId},
        );
      }
    });
  }

  void _handleEmergencyReport() {
    HapticFeedback.heavyImpact();
    Navigator.pushNamed(
      context,
      '/description-input',
      arguments: {
        'categoryId': 'emergency',
        'isEmergency': true,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Select Incident Type',
        variant: CustomAppBarVariant.withBack,
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: const Color(0xFF00C6FF),
          child: Column(
            children: [
              // Progress indicator
              ProgressIndicatorWidget(
                currentStep: 1,
                totalSteps: 3,
                stepLabel: 'Category Selection',
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section header
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What type of incident occurred?',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Select the category that best describes the safety concern. Long press for detailed descriptions.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Category grid
                      _isRefreshing
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: CircularProgressIndicator(
                                  color: const Color(0xFF00C6FF),
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 3.w,
                                mainAxisSpacing: 2.h,
                                childAspectRatio: 0.85,
                              ),
                              itemCount: _incidentCategories.length,
                              itemBuilder: (context, index) {
                                final category = _incidentCategories[index];
                                return FadeTransition(
                                  opacity: Tween<double>(begin: 0.0, end: 1.0)
                                      .animate(
                                    CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(
                                        index * 0.1,
                                        (index * 0.1) + 0.3,
                                        curve: Curves.easeOut,
                                      ),
                                    ),
                                  ),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.2),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: _animationController,
                                        curve: Interval(
                                          index * 0.1,
                                          (index * 0.1) + 0.3,
                                          curve: Curves.easeOut,
                                        ),
                                      ),
                                    ),
                                    child: IncidentCategoryCard(
                                      categoryId: category['id'] as String,
                                      title: category['title'] as String,
                                      description:
                                          category['description'] as String,
                                      iconName: category['icon'] as String,
                                      priority: category['priority'] as String,
                                      priorityColor: category['color'] as Color,
                                      isSelected:
                                          _selectedCategory == category['id'],
                                      onTap: () => _handleCategorySelection(
                                          category['id'] as String),
                                    ),
                                  ),
                                );
                              },
                            ),

                      SizedBox(height: 3.h),

                      // Anonymity reminder
                      AnonymityReminderWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleEmergencyReport,
        backgroundColor: const Color(0xFFFF4757),
        icon: CustomIconWidget(
          iconName: 'warning',
          color: Colors.white,
          size: 24,
        ),
        label: Text(
          'EMERGENCY',
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
