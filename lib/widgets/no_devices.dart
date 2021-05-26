import 'package:flutter/material.dart';

class NoDevices extends StatelessWidget {
  const NoDevices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.device_hub, size: 40,),
        SizedBox(height: 20),
        Text(
          'Nenhum dispositivo encontrado',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black54,
          ),
        )
      ],
    );
  }
}