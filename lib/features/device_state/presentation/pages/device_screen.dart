import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_porta/arguments.dart';
import 'package:smart_porta/dependency_injector.dart';
import 'package:smart_porta/features/device_state/presentation/bloc/device_state_bloc.dart';
import 'package:smart_porta/features/device_state/presentation/widgets/device_screen_body.dart';

class DeviceScreen extends StatefulWidget {
  static const String id = "device";

  const DeviceScreen({Key? key}) : super(key: key);

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  Widget build(BuildContext context) {
    final Arguments args =
        ModalRoute.of(context)!.settings.arguments as Arguments;

    return BlocProvider(
      create: (context) => sl.get<DeviceStateBloc>()
        ..add(DeviceStateGetState(id: args.device.id)),
      child: DeviceScreenBody(
        device: args.device,
      ),
    );
  }
}
