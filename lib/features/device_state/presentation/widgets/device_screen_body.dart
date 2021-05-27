import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/device_state/presentation/bloc/device_state_bloc.dart';
import 'package:smart_porta/screens/landing.dart';

class DeviceScreenBody extends StatefulWidget {
  final String name;

  const DeviceScreenBody({Key? key, required this.name}) : super(key: key);

  @override
  _DeviceScreenBodyState createState() => _DeviceScreenBodyState();
}

class _DeviceScreenBodyState extends State<DeviceScreenBody> {
  void onChanged(bool newValue) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
              return;
            }
            Navigator.pushNamedAndRemoveUntil(
              context,
              LandingScreen.id,
              (route) => false,
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<DeviceStateBloc, DeviceStateState>(
        builder: (context, state) {
          if (state is DeviceStateLoaded) {
            final bool isLocked = state.isLocked;

            return ListTile(
              leading: Icon(Icons.door_sliding),
              title: Text(isLocked ? "Fechada" : "Aberta"),
              trailing: IconButton(
                tooltip: "Dispositivo está ${isLocked ? "fechado" : "aberto"}",
                onPressed: () => onChanged(!isLocked),
                icon: Icon(isLocked ? Icons.lock : Icons.lock_open),
              ),
            );
          } else if (state is DeviceStateError) {
            final Failure failure = state.failure;

            if (failure is NoUserFailure) {
              return Center(
                child: Text("Nenhum usuário logado"),
              );
            } else if (failure is NoDeviceFailure) {
              return Center(
                child: Text("Falha ao obter dispositivo"),
              );
            }
            return ListTile(
              leading: Icon(Icons.lock),
              title: Text("Erro"),
              trailing: Switch(
                value: false,
                onChanged: onChanged,
              ),
            );
          }

          return Shimmer.fromColors(
            baseColor: Theme.of(context).scaffoldBackgroundColor,
            highlightColor: Theme.of(context).accentColor,
            child: ListTile(
              leading: SizedBox(
                width: 24,
                height: 24,
              ),
              title: SizedBox(width: 40),
              trailing: SizedBox(
                width: 16,
                height: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
