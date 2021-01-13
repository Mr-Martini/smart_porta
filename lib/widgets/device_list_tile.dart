import 'package:flutter/material.dart';

class DeviceListTile extends StatelessWidget {
  final String name;
  const DeviceListTile({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.lock),
      title: Text(name),
    );
  }
}