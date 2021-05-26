import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_app_bar.dart';
import '../home_body.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  static const String id = "home";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _raw = "";
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void registerDevice() async {
    if (_raw == "-1") return;

    final payload = json.decode(_raw);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('devices')
        .doc(payload["id"])
        .set(payload);
  }

  void _signIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      if (googleSignInAccount == null) return;
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on PlatformException catch (err) {
      print(err);
    } catch (err) {
      print(err);
    }
  }

  void _scanQrCode() async {
    // Platform messages may fail, so we use a try/catch PlatformException.

    if (_auth.currentUser == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'É necessário login para adicionar dipositivos',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _signIn();
              },
              child: Text('Login'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.QR);
      print(qrCode);

      if (!mounted) return;

      setState(() {
        _raw = qrCode;
      });
      registerDevice();
    } on PlatformException {
      print('Failed to get platform version.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQrCode,
        tooltip: 'Adicionar dispositivo',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}
