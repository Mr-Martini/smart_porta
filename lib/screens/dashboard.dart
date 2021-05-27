import 'package:flutter/material.dart';
import 'package:smart_porta/features/scan_device/presentation/widgets/scan_device_button.dart';

import '../widgets/dashboard/home_app_bar.dart';
import '../widgets/dashboard/dashboard_body.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  static const String id = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: DashboardBody(),
      floatingActionButton: ScanDeviceButton(),
    );
  }
}
