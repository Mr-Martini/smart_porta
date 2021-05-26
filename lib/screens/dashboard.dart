import 'package:flutter/material.dart';
import 'package:smart_porta/features/scan_device/presentation/widgets/scan_device_button.dart';

import '../home_app_bar.dart';
import '../home_body.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  static const String id = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(),
      floatingActionButton: ScanDeviceButton(),
    );
  }
}
