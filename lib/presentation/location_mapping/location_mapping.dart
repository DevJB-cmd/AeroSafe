import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/airport_zone_card.dart';
import './widgets/manual_coordinates_dialog.dart';
import './widgets/zone_details_sheet.dart';

/// Location Mapping Screen for AEROSAFE
/// Provides interactive airport blueprint selection with GPS integration
/// Step 2/3 in the incident reporting flow
class LocationMapping extends StatefulWidget {
  const LocationMapping({super.key});

  @override
  State<LocationMapping> createState() => _LocationMappingState();
}

class _LocationMappingState extends State<LocationMapping>
    with SingleTickerProviderStateMixin {
  // Map controller
  GoogleMapController? _mapController;

  // Selected zone data
  Map<String, dynamic>? _selectedZone;

  // GPS location
  bool _isLoadingLocation = false;
  bool _gpsEnabled = false;

  // View mode
  bool _is3DView = false;

  // Bottom navigation
  int _currentBottomIndex = 3; // Map tab

  // Animation controller for zone selection
  late AnimationController _selectionAnimationController;

  // Airport zones with coordinates
  final List<Map<String, dynamic>> _airportZones = [
    {
      "id": "zone_1",
      "name": "Runway 09/27",
      "type": "Runway",
      "coordinates": LatLng(6.1656, 1.2545),
      "description": "Main runway for takeoff and landing operations",
      "recentIncidents": 3,
      "lastIncident": "2 days ago",
      "priority": "high",
      "color": const Color(0xFFFF4757),
    },
    {
      "id": "zone_2",
      "name": "Terminal Building",
      "type": "Terminal",
      "coordinates": LatLng(6.1665, 1.2555),
      "description": "Main passenger terminal and check-in area",
      "recentIncidents": 5,
      "lastIncident": "1 day ago",
      "priority": "medium",
      "color": const Color(0xFFFFB347),
    },
    {
      "id": "zone_3",
      "name": "Apron Area",
      "type": "Apron",
      "coordinates": LatLng(6.1660, 1.2550),
      "description": "Aircraft parking and ground handling zone",
      "recentIncidents": 7,
      "lastIncident": "3 hours ago",
      "priority": "high",
      "color": const Color(0xFFFF4757),
    },
    {
      "id": "zone_4",
      "name": "Baggage Handling",
      "type": "Baggage",
      "coordinates": LatLng(6.1670, 1.2560),
      "description": "Baggage sorting and loading area",
      "recentIncidents": 2,
      "lastIncident": "5 days ago",
      "priority": "low",
      "color": const Color(0xFF00D95A),
    },
    {
      "id": "zone_5",
      "name": "Maintenance Hangar",
      "type": "Maintenance",
      "coordinates": LatLng(6.1650, 1.2540),
      "description": "Aircraft maintenance and repair facility",
      "recentIncidents": 1,
      "lastIncident": "1 week ago",
      "priority": "low",
      "color": const Color(0xFF00D95A),
    },
    {
      "id": "zone_6",
      "name": "Control Tower",
      "type": "ATC",
      "coordinates": LatLng(6.1668, 1.2548),
      "description": "Air traffic control and communications center",
      "recentIncidents": 0,
      "lastIncident": "Never",
      "priority": "low",
      "color": const Color(0xFF00D95A),
    },
  ];

  // Map markers
  Set<Marker> _markers = {};

  // Initial camera position (Lomé-Tokoin Airport, Togo)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(6.1656, 1.2545),
    zoom: 16.0,
    tilt: 0,
  );

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _createMarkers();
    _checkLocationPermission();
  }

  void _initializeAnimations() {
    _selectionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _createMarkers() {
    _markers = _airportZones.map((zone) {
      return Marker(
        markerId: MarkerId(zone["id"] as String),
        position: zone["coordinates"] as LatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _getMarkerHue(zone["priority"] as String),
        ),
        infoWindow: InfoWindow(
          title: zone["name"] as String,
          snippet: zone["type"] as String,
        ),
        onTap: () => _onZoneSelected(zone),
      );
    }).toSet();
  }

  double _getMarkerHue(String priority) {
    switch (priority) {
      case "high":
        return BitmapDescriptor.hueRed;
      case "medium":
        return BitmapDescriptor.hueOrange;
      default:
        return BitmapDescriptor.hueGreen;
    }
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    setState(() => _gpsEnabled = true);
  }

  Future<void> _getCurrentLocation() async {
    if (!_gpsEnabled) {
      _showLocationDisabledDialog();
      return;
    }

    setState(() => _isLoadingLocation = true);

    try {
      Position position = await Geolocator.getCurrentPosition(
        accuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });

      // Move camera to current location
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );

      // Find nearest zone
      _findNearestZone(position);
    } catch (e) {
      setState(() => _isLoadingLocation = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get location: ${e.toString()}'),
            backgroundColor: const Color(0xFFFF4757),
          ),
        );
      }
    }
  }

  void _findNearestZone(Position position) {
    double minDistance = double.infinity;
    Map<String, dynamic>? nearestZone;

    for (var zone in _airportZones) {
      LatLng zoneCoords = zone["coordinates"] as LatLng;
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        zoneCoords.latitude,
        zoneCoords.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestZone = zone;
      }
    }

    if (nearestZone != null && minDistance < 500) {
      _showNearestZoneDialog(nearestZone, minDistance);
    }
  }

  void _showNearestZoneDialog(Map<String, dynamic> zone, double distance) {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: const Color(0xFF00C6FF),
                size: 24,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  'Nearest Zone Detected',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                zone["name"] as String,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Distance: ${distance.toStringAsFixed(0)}m',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                zone["description"] as String,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _onZoneSelected(zone);
              },
              child: const Text('Select Zone'),
            ),
          ],
        );
      },
    );
  }

  void _showLocationDisabledDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'location_off',
                color: const Color(0xFFFF4757),
                size: 24,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  'Location Services Disabled',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          content: Text(
            'Please enable location services to use GPS features. You can still select zones manually.',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onZoneSelected(Map<String, dynamic> zone) {
    HapticFeedback.mediumImpact();
    setState(() => _selectedZone = zone);
    _selectionAnimationController.forward().then((_) {
      _selectionAnimationController.reverse();
    });

    // Show zone details sheet
    _showZoneDetailsSheet(zone);
  }

  void _showZoneDetailsSheet(Map<String, dynamic> zone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ZoneDetailsSheet(
        zone: zone,
        onConfirm: () {
          Navigator.pop(context);
          _continueToNextStep();
        },
      ),
    );
  }

  void _toggleViewMode() {
    HapticFeedback.lightImpact();
    setState(() => _is3DView = !_is3DView);

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _initialPosition.target,
          zoom: _initialPosition.zoom,
          tilt: _is3DView ? 45.0 : 0.0,
          bearing: _is3DView ? 30.0 : 0.0,
        ),
      ),
    );
  }

  void _showManualCoordinatesDialog() {
    showDialog(
      context: context,
      builder: (context) => ManualCoordinatesDialog(
        onConfirm: (lat, lng) {
          final customZone = {
            "id": "custom_zone",
            "name": "Custom Location",
            "type": "Custom",
            "coordinates": LatLng(lat, lng),
            "description": "Manually specified coordinates",
            "recentIncidents": 0,
            "lastIncident": "N/A",
            "priority": "medium",
            "color": const Color(0xFF00C6FF),
          };
          _onZoneSelected(customZone);
        },
      ),
    );
  }

  void _continueToNextStep() {
    if (_selectedZone != null) {
      Navigator.pushNamed(
        context,
        '/description-input',
        arguments: {
          'selectedZone': _selectedZone,
          'timestamp': DateTime.now(),
        },
      );
    }
  }

  @override
  void dispose() {
    _selectionAnimationController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Incident Location',
        variant: CustomAppBarVariant.withBack,
        subtitle: 'Step 2/3',
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: _gpsEnabled ? 'gps_fixed' : 'gps_off',
              color: _gpsEnabled
                  ? const Color(0xFF00D95A)
                  : theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              size: 24,
            ),
            onPressed:
                _gpsEnabled ? _getCurrentLocation : _checkLocationPermission,
            tooltip: _gpsEnabled ? 'Get Current Location' : 'Enable GPS',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: _gpsEnabled,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            onTap: (position) {
              // Deselect zone on map tap
              setState(() => _selectedZone = null);
            },
          ),

          // Progress indicator
          Positioned(
            top: 2.h,
            left: 4.w,
            right: 4.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00D95A),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.66,
                        backgroundColor:
                            theme.colorScheme.outline.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF00C6FF),
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '2/3',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00C6FF),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Zone cards
          Positioned(
            bottom: _selectedZone != null ? 20.h : 12.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 16.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemCount: _airportZones.length,
                separatorBuilder: (context, index) => SizedBox(width: 3.w),
                itemBuilder: (context, index) {
                  final zone = _airportZones[index];
                  final isSelected = _selectedZone?["id"] == zone["id"];
                  return AirportZoneCard(
                    zone: zone,
                    isSelected: isSelected,
                    onTap: () => _onZoneSelected(zone),
                  );
                },
              ),
            ),
          ),

          // Loading indicator
          if (_isLoadingLocation)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF00C6FF),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Getting your location...',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // 3D toggle button
          Positioned(
            right: 4.w,
            bottom: _selectedZone != null ? 28.h : 20.h,
            child: FloatingActionButton(
              heroTag: '3d_toggle',
              onPressed: _toggleViewMode,
              backgroundColor: theme.colorScheme.surface,
              child: CustomIconWidget(
                iconName: _is3DView ? '3d_rotation' : 'map',
                color: _is3DView
                    ? const Color(0xFF00C6FF)
                    : theme.colorScheme.onSurface,
                size: 24,
              ),
            ),
          ),

          // Manual coordinates button
          Positioned(
            right: 4.w,
            bottom: _selectedZone != null ? 36.h : 28.h,
            child: FloatingActionButton(
              heroTag: 'manual_coords',
              onPressed: _showManualCoordinatesDialog,
              backgroundColor: theme.colorScheme.surface,
              child: CustomIconWidget(
                iconName: 'edit_location',
                color: theme.colorScheme.onSurface,
                size: 24,
              ),
            ),
          ),

          // Continue button
          if (_selectedZone != null)
            Positioned(
              bottom: 2.h,
              left: 4.w,
              right: 4.w,
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: _continueToNextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C6FF),
                    foregroundColor: const Color(0xFF0A1A3A),
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue to Description',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: const Color(0xFF0A1A3A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: 'arrow_forward',
                        color: const Color(0xFF0A1A3A),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) {
          if (index != _currentBottomIndex) {
            setState(() => _currentBottomIndex = index);
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home-screen');
                break;
              case 1:
                Navigator.pushNamed(context, '/incident-selection');
                break;
              case 2:
                Navigator.pushNamed(context, '/admin-authentication');
                break;
              case 3:
                // Current screen
                break;
              case 4:
                Navigator.pushNamed(context, '/home-screen');
                break;
            }
          }
        },
        showAdminTab: true,
      ),
    );
  }
}
