import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_porta/model/devices.dart';
import 'package:smart_porta/widgets/no_devices.dart';

class DeviceState extends StatelessWidget {
  DeviceState({Key key, @required this.device}) : super(key: key);

  final Device device;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    void onChanged(bool isLocked) async {
      try {
        Map<String, dynamic> data = {
          "isLocked": isLocked,
          "openPercent": isLocked ? 0 : 100,
          "deviceId": device.id
        };

        await _firestore.collection("incoming").doc(device.id).set(data);
      } catch (err) {
        final snackBar = SnackBar(content: Text("erro ao enviar"));

        Scaffold.of(context).showSnackBar(snackBar);
      }
    }

    return StreamBuilder(
      stream: _firestore.collection("devices").doc(device.id).snapshots(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final DocumentSnapshot data = snapshot.data;
            if (data.exists) {
              final Device deviceDB = Device.fromSnapshot(data.data());
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.lock),
                    title: Text(
                      deviceDB.isLocked ? "Status: Fechada" : "Status: Aberta",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54
                      ),
                    ),
                    trailing: Switch(
                      value: deviceDB.isLocked,
                      onChanged: onChanged,
                    ),
                  );
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
