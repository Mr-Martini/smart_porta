import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/update_device_state/presentation/bloc/update_device_state_bloc.dart';

class UpdateDeviceStateWidget extends StatefulWidget {
  final String id;

  const UpdateDeviceStateWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _UpdateDeviceStateWidgetState createState() =>
      _UpdateDeviceStateWidgetState();
}

class _UpdateDeviceStateWidgetState extends State<UpdateDeviceStateWidget> {
  void generateSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateDeviceStateBloc, UpdateDeviceStateState>(
      listener: (BuildContext context, UpdateDeviceStateState state) {
        if (state is UpdateDeviceLoaded) {

        } else if (state is UpdateDeviceError) {
          final Failure failure = state.failure;

          if (failure is NotAllowedFailure) {
            generateSnackBar("Sem permissão");
          } else if (failure is NoUserFailure) {
            generateSnackBar("Nenhum usuário conectado");
          } else if (failure is UnknownDioFailure) {
            generateSnackBar("Falha ao atualizar dispositivo");
          } else {
            generateSnackBar("Erro desconhecido");
          }
        }
      },
      child: BlocBuilder<UpdateDeviceStateBloc, UpdateDeviceStateState>(
        builder: (BuildContext context, UpdateDeviceStateState state) {
          if (state is UpdateDeviceLoading) {
            return Container(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(),
            );
          }

          return Container();
        },
      ),
    );
  }
}
