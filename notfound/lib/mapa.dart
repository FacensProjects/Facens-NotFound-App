import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class MyMapaPage extends StatefulWidget {
  String location;

  MyMapaPage({Key? key, required this.location}) : super(key: key);

  @override
  _MyMapaPageState createState() => _MyMapaPageState();
}

class _MyMapaPageState extends State<MyMapaPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotFound - Facens'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Image.asset('images/${widget.location}.png'),
      ),
    );
  }
}
