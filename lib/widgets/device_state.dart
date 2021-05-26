import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_porta/model/devices.dart';
import 'package:smart_porta/widgets/no_devices.dart';
import 'package:smart_porta/widgets/state_list_tile.dart';

class DeviceState extends StatefulWidget {
  DeviceState({Key? key, required this.device}) : super(key: key);

  final Device device;

  @override
  _DeviceStateState createState() => _DeviceStateState();
}

class _DeviceStateState extends State<DeviceState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool deviceIsLocked = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          _firestore.collection("devices").doc(widget.device.id).snapshots(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final DocumentSnapshot data = snapshot.data;
            if (data.exists) {
              final snapshot = data.data() as Map<String, dynamic>;
              final Device deviceDB = Device.fromSnapshot(snapshot);
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return StateListTile(device: deviceDB);
                },
              );
            }
          }
        }
        return NoDevices();
      },
    );
  }
}
