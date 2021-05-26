import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_porta/dependency_injector.dart' show sl;
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/scan_device/presentation/bloc/scan_device_bloc.dart';

class ScanDeviceButton extends StatelessWidget {
  const ScanDeviceButton({Key? key}) : super(key: key);

  void generateSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          label: 'Ok',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanDeviceBloc>(
      create: (context) => sl.get<ScanDeviceBloc>(),
      child: Builder(
        builder: (context) => BlocListener<ScanDeviceBloc, ScanDeviceState>(
          listener: (context, state) {
            if (state is ScanDeviceLoaded) {
              generateSnackBar(context, "Dispositivo adicionado!");
            } else if (state is ScanDeviceError) {
              final Failure failure = state.failure;

              if (failure is NoUserFailure) {
                generateSnackBar(context, "Nenhum usuário logado!");
              } else if (failure is QRCodeFailure) {
                generateSnackBar(context, "Falha na leitura do código QR!");
              } else if (failure is QRCodeCanceledFailure) {
              } else {
                generateSnackBar(context, "Erro desconhecido");
              }
            }
          },
          child: BlocBuilder<ScanDeviceBloc, ScanDeviceState>(
            builder: (context, state) {
              if (state is ScanDeviceLoading) {
                return FloatingActionButton(
                  onPressed: null,
                  child: CircularProgressIndicator(),
                );
              }

              return FloatingActionButton(
                onPressed: () => BlocProvider.of<ScanDeviceBloc>(context)
                    .add(ScanDeviceAction()),
                child: Icon(Icons.qr_code),
              );
            },
          ),
        ),
      ),
    );
  }
}
