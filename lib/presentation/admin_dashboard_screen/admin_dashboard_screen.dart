import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/dashboard_header_widget.dart';
import './widgets/health_metrics_widget.dart';
import './widgets/heatmap_visualization_widget.dart';
import './widgets/incident_feed_widget.dart';
import './widgets/weekly_statistics_widget.dart';
import './widgets/anonymous_messages_widget.dart';

/// Admin Dashboard Screen for ANAC Togo agents
/// Provides cyber-themed control room interface for monitoring aviation safety incidents
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  int _currentBottomNavIndex = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Mock data for agent
  final String _agentId = 'ANAC-TG-2547';
  final int _notificationCount = 3;

  // Mock data for health metrics
  final double _incidentTrendPercentage = 78.0;
  final double _responseTimePercentage = 92.0;
  final double _resolutionRatePercentage = 85.0;

  // Mock data for heatmap locations
  final List<Map<String, dynamic>> _incidentLocations = [
    {
      'latitude': 6.1656,
      'longitude': 1.2544,
      'incidentCount': 12,
      'location': 'Lomé-Tokoin Airport',
    },
    {
      'latitude': 9.5496,
      'longitude': 0.8566,
      'incidentCount': 5,
      'location': 'Niamtougou Airport',
    },
    {
      'latitude': 8.9753,
      'longitude': 1.0927,
      'incidentCount': 3,
      'location': 'Kara Airport',
    },
  ];

  // Mock data for incidents
  final List<Map<String, dynamic>> _incidents = [
    {
      'id': 'INC-2025-001',
      'category': 'In-Flight',
      'priority': 'critical',
      'description':
          'Engine vibration detected during climb phase on flight TG-245',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'status': 'new',
    },
    {
      'id': 'INC-2025-002',
      'category': 'Runway',
      'priority': 'high',
      'description':
          'Foreign object debris spotted on runway 23L during pre-flight inspection',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      'status': 'investigating',
    },
    {
      'id': 'INC-2025-003',
      'category': 'Baggage/Equipment',
      'priority': 'medium',
      'description': 'Baggage handling conveyor belt malfunction in Terminal 2',
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      'status': 'assigned',
    },
    {
      'id': 'INC-2025-004',
      'category': 'Behavior',
      'priority': 'high',
      'description':
          'Unruly passenger behavior reported on international flight',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'status': 'resolved',
    },
    {
      'id': 'INC-2025-005',
      'category': 'Material',
      'priority': 'low',
      'description':
          'Minor hydraulic fluid leak detected during routine maintenance',
      'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
      'status': 'monitoring',
    },
    {
      'id': 'INC-2025-006',
      'category': 'Other',
      'priority': 'medium',
      'description':
          'Communication system intermittent issues in control tower',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'status': 'investigating',
    },
  ];

  // Mock data for weekly statistics
  final List<Map<String, dynamic>> _weeklyData = [
    {'day': 'Mon', 'count': 8},
    {'day': 'Tue', 'count': 12},
    {'day': 'Wed', 'count': 6},
    {'day': 'Thu', 'count': 15},
    {'day': 'Fri', 'count': 10},
    {'day': 'Sat', 'count': 4},
    {'day': 'Sun', 'count': 3},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    HapticFeedback.mediumImpact();

    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Dashboard updated'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _handleNotificationTap() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_notificationCount new notifications'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleLogout() {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content:
            const Text('Are you sure you want to logout from admin dashboard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/qr-access-screen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorLight,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _handleLocationTap(Map<String, dynamic> location) {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(location['location'] as String),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Incident Count: ${location['incidentCount']}',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 1.h),
              Text(
                'Coordinates: ${location['latitude']}, ${location['longitude']}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to detailed location view
              },
              child: const Text('View Details'),
            ),
          ],
        );
      },
    );
  }

  void _handleIncidentTap(Map<String, dynamic> incident) {
    HapticFeedback.lightImpact();
    // Navigate to incident detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening incident ${incident['id']}'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleIncidentLongPress(Map<String, dynamic> incident) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(1.w),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'person_add',
                  color: colorScheme.secondary,
                  size: 6.w,
                ),
                title: const Text('Assign Agent'),
                onTap: () {
                  Navigator.pop(context);
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Agent assignment feature')),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'priority_high',
                  color: AppTheme.warningColor,
                  size: 6.w,
                ),
                title: const Text('Set Priority'),
                onTap: () {
                  Navigator.pop(context);
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Priority setting feature')),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'chat',
                  color: colorScheme.secondary,
                  size: 6.w,
                ),
                title: const Text('Start Chat'),
                onTap: () {
                  Navigator.pop(context);
                  HapticFeedback.lightImpact();
                  Navigator.pushNamed(context, '/anonymous-chat-screen');
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  void _handleEmergencyAlert() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'warning',
                color: AppTheme.errorLight,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              const Text('Emergency Alert'),
            ],
          ),
          content: const Text(
            'Initiate emergency alert system? This will notify all ANAC agents and trigger priority protocols.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Emergency alert initiated'),
                    backgroundColor: AppTheme.errorLight,
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorLight,
              ),
              child: const Text('Initiate Alert'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            DashboardHeaderWidget(
              agentId: _agentId,
              notificationCount: _notificationCount,
              onNotificationTap: _handleNotificationTap,
              onLogoutTap: _handleLogout,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: colorScheme.secondary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Live indicator
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 3.w,
                                  height: 3.w,
                                  decoration: BoxDecoration(
                                    color: AppTheme.successColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.successColor
                                            .withValues(alpha: 0.5),
                                        blurRadius: 8.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Dashboard Auto-Refresh Active',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      // Health Metrics
                      HealthMetricsWidget(
                        incidentTrendPercentage: _incidentTrendPercentage,
                        responseTimePercentage: _responseTimePercentage,
                        resolutionRatePercentage: _resolutionRatePercentage,
                      ),
                      SizedBox(height: 3.h),

                      // Heatmap Visualization
                      HeatmapVisualizationWidget(
                        incidentLocations: _incidentLocations,
                        onLocationTap: _handleLocationTap,
                      ),
                      SizedBox(height: 3.h),

                      // Weekly Statistics
                      WeeklyStatisticsWidget(
                        weeklyData: _weeklyData,
                      ),
                      SizedBox(height: 3.h),

                      // Incident Feed
                      IncidentFeedWidget(
                        incidents: _incidents,
                        onIncidentTap: _handleIncidentTap,
                        onIncidentLongPress: _handleIncidentLongPress,
                      ),
                      SizedBox(height: 3.h),

                      // Anonymous Messages
                      const AnonymousMessagesWidget(),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleEmergencyAlert,
        backgroundColor: AppTheme.errorLight,
        icon: CustomIconWidget(
          iconName: 'warning',
          color: colorScheme.onError,
          size: 6.w,
        ),
        label: Text(
          'Emergency Alert',
          style: theme.textTheme.labelLarge?.copyWith(
            color: colorScheme.onError,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentBottomNavIndex,
        showRoleBadge: true,
        roleType: 'admin',
        onTap: (index) {
          setState(() => _currentBottomNavIndex = index);
          HapticFeedback.lightImpact();

          // Navigate based on index
          switch (index) {
            case 0:
              // Already on dashboard
              break;
            case 1:
              Navigator.pushNamed(context, '/qr-access-screen');
              break;
            case 2:
              Navigator.pushNamed(context, '/anonymous-chat-screen');
              break;
            case 3:
              Navigator.pushNamed(context, '/settings-screen');
              break;
          }
        },
      ),
    );
  }
}
