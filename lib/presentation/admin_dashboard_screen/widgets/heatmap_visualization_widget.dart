import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Interactive heatmap visualization for geographic incident clustering
class HeatmapVisualizationWidget extends StatefulWidget {
  final List<Map<String, dynamic>> incidentLocations;
  final Function(Map<String, dynamic>) onLocationTap;

  const HeatmapVisualizationWidget({
    super.key,
    required this.incidentLocations,
    required this.onLocationTap,
  });

  @override
  State<HeatmapVisualizationWidget> createState() =>
      _HeatmapVisualizationWidgetState();
}

class _HeatmapVisualizationWidgetState
    extends State<HeatmapVisualizationWidget> {
  final MapController _mapController = MapController();

  Color _getIntensityColor(int incidentCount) {
    if (incidentCount >= 10) return AppTheme.errorLight;
    if (incidentCount >= 5) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'map',
                    color: colorScheme.secondary,
                    size: 6.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Incident Heatmap',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Text(
                  'Togo Airports',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
                width: 1.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: const LatLng(6.1256, 1.2323), // Lomé, Togo
                  initialZoom: 8.0,
                  minZoom: 6.0,
                  maxZoom: 15.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.anac.aerosafe',
                  ),
                  CircleLayer(
                    circles: widget.incidentLocations.map((location) {
                      final incidentCount =
                          location['incidentCount'] as int? ?? 1;
                      return CircleMarker(
                        point: LatLng(
                          location['latitude'] as double,
                          location['longitude'] as double,
                        ),
                        radius: (incidentCount * 3).toDouble(),
                        color: _getIntensityColor(incidentCount)
                            .withValues(alpha: 0.6),
                        borderColor: _getIntensityColor(incidentCount),
                        borderStrokeWidth: 2.0,
                        useRadiusInMeter: false,
                      );
                    }).toList(),
                  ),
                  MarkerLayer(
                    markers: widget.incidentLocations.map((location) {
                      return Marker(
                        point: LatLng(
                          location['latitude'] as double,
                          location['longitude'] as double,
                        ),
                        width: 10.w,
                        height: 10.w,
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            widget.onLocationTap(location);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(
                context: context,
                color: AppTheme.successColor,
                label: 'Low (1-4)',
              ),
              _buildLegendItem(
                context: context,
                color: AppTheme.warningColor,
                label: 'Medium (5-9)',
              ),
              _buildLegendItem(
                context: context,
                color: AppTheme.errorLight,
                label: 'High (10+)',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required BuildContext context,
    required Color color,
    required String label,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 3.w,
          height: 3.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 1.0,
            ),
          ),
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }
}
