import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_porta/dependency_injector.dart' as dp;
import 'package:smart_porta/features/device_state/presentation/pages/device_screen.dart';
import 'package:smart_porta/screens/dashboard.dart';
import 'package:smart_porta/screens/home.dart';
import 'package:vrouter/vrouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  dp.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool get isAuthenticated {
    final auth = dp.sl.get<FirebaseAuth>();

    return auth.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return VRouter(
      title: 'Smart porta',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      mode: VRouterModes.history,
      debugShowCheckedModeBanner: false,
      initialUrl: DashboardScreen.id,
      routes: [
        VGuard(
          beforeEnter: (vRedirector) async =>
              !isAuthenticated ? vRedirector.push(WelcomeScreen.id) : null,
          stackedRoutes: [
            VWidget(path: DashboardScreen.id, widget: DashboardScreen()),
            VWidget(path: DeviceScreen.id, widget: DeviceScreen()),
          ],
        ),
        VGuard(
          beforeEnter: (vRedirector) async =>
              isAuthenticated ? vRedirector.push(DashboardScreen.id) : null,
          stackedRoutes: [
            VWidget(path: WelcomeScreen.id, widget: WelcomeScreen()),
          ],
        ),
      ],
    );
  }
}
