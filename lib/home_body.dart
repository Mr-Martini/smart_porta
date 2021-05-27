import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_porta/dependency_injector.dart';
import 'package:smart_porta/model/devices.dart';
import './widgets/no_devices.dart';
import './model/devices.dart';
import './widgets/device_list_tile.dart';

class DashboardBody extends StatefulWidget {
  DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  FirebaseFirestore _firestore = sl.get<FirebaseFirestore>();
  FirebaseAuth _auth = sl.get<FirebaseAuth>();

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user == null) return NoDevices();
    return StreamBuilder(
      stream: _firestore
          .collection('users')
          .doc(user.uid)
          .collection('devices')
          .snapshots(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final List<Device> devices = [];
            final QuerySnapshot query = snapshot.data;
            final List<QueryDocumentSnapshot> listDocs = query.docs;
            for (QueryDocumentSnapshot document in listDocs) {
              final Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              final Device device = Device.fromSnapshot(data);
              devices.add(device);
            }
            return ListView.builder(
              itemCount: devices.length,
              itemBuilder: (BuildContext context, int index) {
                final Device device = devices[index];
                return DeviceListTile(device: device);
              },
            );
          } else {
            return NoDevices();
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
