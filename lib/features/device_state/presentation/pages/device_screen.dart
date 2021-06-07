import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_porta/dependency_injector.dart';
import 'package:smart_porta/features/device_state/presentation/bloc/device_state_bloc.dart';
import 'package:smart_porta/features/device_state/presentation/widgets/device_screen_body.dart';
import 'package:smart_porta/features/update_device_state/presentation/bloc/update_device_state_bloc.dart';
import 'package:vrouter/vrouter.dart';

class DeviceScreen extends StatefulWidget {
  static const String id = "/device";

  const DeviceScreen({Key? key}) : super(key: key);

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  Widget build(BuildContext context) {
    final device = context.vRouter.queryParameters;

    final String? id = device["id"];
    final String? name = device["name"];
    if (id == null || id.isEmpty || name == null || name.isEmpty) {
      return Center(
        child: Text("Failed to get data for device $name"),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<DeviceStateBloc>()
            ..add(
              DeviceStateGetState(id: id),
            ),
        ),
        BlocProvider(create: (context) => sl.get<UpdateDeviceStateBloc>()),
      ],
      child: DeviceScreenBody(
        name: name,
        id: id,
      ),
    );
  }
}
