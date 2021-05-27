import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_porta/features/device_state/presentation/pages/device_screen.dart';
import 'package:smart_porta/guards/guard.dart';
import 'package:smart_porta/screens/dashboard.dart';
import 'package:smart_porta/screens/landing.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LandingScreen.id:
        return MaterialPageRoute(builder: (_) => Guard(), settings: settings);
      case DashboardScreen.id:
        return MaterialPageRoute(builder: (_) => DashboardScreen(), settings: settings);
      case DeviceScreen.id:
        return MaterialPageRoute(builder: (_) => DeviceScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => Guard(), settings: settings);
    }
  }
}