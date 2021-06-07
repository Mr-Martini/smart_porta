import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/update_device_state/data/models/update_device_state_model.dart';
import 'package:dio/dio.dart';

abstract class UpdateDeviceStateRemoteService {
  Future<UpdateDeviceStateModel> updateState(bool state, String id);
}

class UpdateDeviceStateRemoteServiceImpl
    implements UpdateDeviceStateRemoteService {
  final FirebaseAuth auth;
  final Dio dio;

  UpdateDeviceStateRemoteServiceImpl({required this.auth, required this.dio});

  @override
  Future<UpdateDeviceStateModel> updateState(bool state, String id) async {
    if (kIsWeb) throw NotAllowedException();

    final User? user = auth.currentUser;

    if (user == null) throw NoUserException();

    final Map<String, dynamic> data = {"deviceId": id, "state": state};

    const String url =
        "https://us-central1-projeto-integrador-93d50.cloudfunctions.net/handleApps";
    await dio.post(url, data: data);

    return UpdateDeviceStateModel();
  }
}
