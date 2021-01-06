import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import './home_app_bar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart porta',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        buttonColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Typography.blackRedmond,
      ),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.red,
        buttonColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Typography.blackRedmond,
      ),
      home: MyHomePage(title: 'Início'),
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
      appBar: HomeAppBar(),
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
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}

List<Widget> _buildBody(String deviceId, BuildContext context) {
  if (deviceId != null) {
    return <Widget>[
      Text(
        'Id do dispositivo:',
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black54,
        ),
      ),
      Text(
        '$deviceId',
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black54,
        ),
      ),
    ];
  }
  return <Widget>[
    Text(
      'Nenhum dispositivo cadastrado.',
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black54,
      ),
    ),
  ];
}
