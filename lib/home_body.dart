import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_porta/model/devices.dart';
import './widgets/no_devices.dart';
import './model/devices.dart';
import './widgets/device_list_tile.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User user = _auth.currentUser;
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
              final Device device = Device.fromSnapshot(document.data());
              devices.add(device);
            }
            return ListView.builder(
              itemCount: devices.length,
              itemBuilder: (BuildContext context, int index) {
                final Device device = devices[index];
                return DeviceListTile(device: device);
              },
            );
          }
        }
        return NoDevices();
      },
    );
  }
}
