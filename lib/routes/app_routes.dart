import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/incident_selection/incident_selection.dart';
import '../presentation/location_mapping/location_mapping.dart';
import '../presentation/admin_authentication/admin_authentication.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/description_input/description_input.dart';
import '../presentation/anonymous_chat_screen/anonymous_chat_screen.dart';
import '../presentation/qr_access_screen/qr_access_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/admin_dashboard_screen/admin_dashboard_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splash = '/splash-screen';
  static const String incidentSelection = '/incident-selection';
  static const String locationMapping = '/location-mapping';
  static const String adminAuthentication = '/admin-authentication';
  static const String home = '/home-screen';
  static const String descriptionInput = '/description-input';
  static const String anonymousChat = '/anonymous-chat-screen';
  static const String qrAccess = '/qr-access-screen';
  static const String settings = '/settings-screen';
  static const String adminDashboard = '/admin-dashboard-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    incidentSelection: (context) => const IncidentSelection(),
    locationMapping: (context) => const LocationMapping(),
    adminAuthentication: (context) => const AdminAuthentication(),
    home: (context) => const HomeScreen(),
    descriptionInput: (context) => const DescriptionInput(),
    anonymousChat: (context) => const AnonymousChatScreen(),
    qrAccess: (context) => const QrAccessScreen(),
    settings: (context) => const SettingsScreen(),
    adminDashboard: (context) => const AdminDashboardScreen(),
  };
}