import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/scan_device/data/models/scan_device_model.dart';

abstract class ScanDeviceLocalDataSource {
  Future<ScanDeviceModel> scan();
}

class ScanDeviceLocalDataSourceImpl implements ScanDeviceLocalDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ScanDeviceLocalDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<ScanDeviceModel> scan() async {
    final User? user = auth.currentUser;

    if (user == null) throw NoUserException();

    final String scanResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancelar",
      true,
      ScanMode.QR,
    );
    if (scanResult == "-1") throw QRCanceledException();

    if (scanResult.isEmpty) throw QRCodeException();

    final payload = jsonDecode(scanResult);

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(payload["id"])
        .set(payload);

    return ScanDeviceModel();
  }
}
