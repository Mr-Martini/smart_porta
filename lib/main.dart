import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart porta',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dispositivos registrados'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _deviceId;

  void _scanQrCode() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.QR);
      print(qrCode);

      if (!mounted) return;

      setState(() {
        _deviceId = qrCode;
      });
    } on PlatformException {
      print('Failed to get platform version.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildBody(_deviceId, context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQrCode,
        tooltip: 'Adicionar dispositivo',
        child: Icon(Icons.add),
      ),
    );
  }
}

List<Widget> _buildBody(String deviceId, BuildContext context) {
  if (deviceId != null) {
    return <Widget>[
      Text(
        'Id do dispositivo:',
      ),
      Text(
        '$deviceId',
        style: Theme.of(context).textTheme.headline4,
      ),
    ];
  }
  return <Widget>[
    Text(
      'Nenhum dispositivo cadastrado.',
    ),
  ];
}
