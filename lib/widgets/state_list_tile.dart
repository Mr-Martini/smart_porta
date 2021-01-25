import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_porta/model/devices.dart';

class StateListTile extends StatefulWidget {
  final Device device;

  StateListTile({Key key, @required this.device}) : super(key: key);

  @override
  _StateListTileState createState() => _StateListTileState();
}

class _StateListTileState extends State<StateListTile> {
  bool isLocked;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    isLocked = widget.device.isLocked;
    super.initState();
  }

  void onChanged(bool newValue, bool deviceIsLocked) async {
    try {
      Map<String, dynamic> data = {
        "isLocked": newValue,
        "openPercent": newValue ? 0 : 100,
        "deviceId": widget.device.id
      };

      await _firestore.collection("incoming").doc(widget.device.id).set(data);
      setState(() {
        isLocked = newValue;
      });
    } catch (err) {
      final snackBar = SnackBar(content: Text("erro ao enviar"));

      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        deviceIsLocked = deviceIsLocked;
      });
    }
  }

  String get getTitle {
    if (isLocked) {
      return "Status: Fechada";
    }
    return "Status: Aberta";
  }

  @override
  Widget build(BuildContext context) {
    final Device device = widget.device;
    return ListTile(
      leading: Icon(Icons.lock),
      title: Text(
        getTitle,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black54,
        ),
      ),
      trailing: Switch(
        value: isLocked,
        onChanged: (value) => onChanged(value, device.isLocked),
      ),
    );
  }
}
