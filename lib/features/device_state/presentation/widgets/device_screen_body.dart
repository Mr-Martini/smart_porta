import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/device_state/presentation/bloc/device_state_bloc.dart';
import 'package:smart_porta/features/update_device_state/presentation/bloc/update_device_state_bloc.dart';
import 'package:smart_porta/features/update_device_state/presentation/widgets/update_device_state.dart';
import 'package:smart_porta/screens/dashboard.dart';
import 'package:vrouter/vrouter.dart';

class DeviceScreenBody extends StatefulWidget {
  final String name;
  final String id;

  const DeviceScreenBody({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  _DeviceScreenBodyState createState() => _DeviceScreenBodyState();
}

class _DeviceScreenBodyState extends State<DeviceScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
          onPressed: () {
            context.vRouter.push(DashboardScreen.id);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<DeviceStateBloc, DeviceStateState>(
        builder: (context, state) {
          if (state is DeviceStateLoaded) {
            final bool isLocked = state.isLocked;

            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Tooltip(
                            message: isLocked ? "Abrir porta" : "Fechar porta",
                            child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () =>
                                  BlocProvider.of<UpdateDeviceStateBloc>(
                                          context)
                                      .add(
                                UpdateDeviceStateAction(
                                  id: state.id,
                                  state: !state.isLocked,
                                ),
                              ),
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Icon(
                                  isLocked ? Icons.lock : Icons.lock_open,
                                  size: 150,
                                ),
                              ),
                            ),
                          ),
                          UpdateDeviceStateWidget(id: widget.id),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        isLocked ? "Fechado" : "Aberto",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
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
            return Center(
              child: InkWell(
                onTap: () => BlocProvider.of<DeviceStateBloc>(context)
                    .add(DeviceStateGetState(id: widget.id)),
                child: Text("Erro desconhecido"),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
