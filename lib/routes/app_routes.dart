import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/incident_selection/incident_selection.dart';
import '../presentation/location_mapping/location_mapping.dart';
import '../presentation/admin_authentication/admin_authentication.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/description_input/description_input.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splash = '/splash-screen';
  static const String incidentSelection = '/incident-selection';
  static const String locationMapping = '/location-mapping';
  static const String adminAuthentication = '/admin-authentication';
  static const String home = '/home-screen';
  static const String descriptionInput = '/description-input';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    incidentSelection: (context) => const IncidentSelection(),
    locationMapping: (context) => const LocationMapping(),
    adminAuthentication: (context) => const AdminAuthentication(),
    home: (context) => const HomeScreen(),
    descriptionInput: (context) => const DescriptionInput(),
  };
}
