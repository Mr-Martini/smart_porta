import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/device_state/data/models/device_state_model.dart';

abstract class DeviceStateRemoteDataSource {
  Future<DeviceStateModel> getState(String id);
}

class DeviceStateRemoteDataSourceImpl implements DeviceStateRemoteDataSource {
  final FirebaseAuth auth;

  final FirebaseFirestore firestore;

  DeviceStateRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<DeviceStateModel> getState(String id) async {
    final User? user = auth.currentUser;

    if (user == null) throw NoUserException();

    final device = await firestore.collection("devices").doc(id).get();

    final data = device.data();

    if (data == null || data.isEmpty) throw NoDeviceException();

    return DeviceStateModel.fromMap(data);
  }
}
