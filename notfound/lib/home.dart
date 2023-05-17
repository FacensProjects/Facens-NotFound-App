import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notfound/api.dart' show searchRa;
import 'package:notfound/menu.dart' show MyMenuPage;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController raController = TextEditingController();

  void showRA() async {
    var response = await searchRa(raController.text);
    if (response?['status']) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyMenuPage(response: response!)),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Estudante com RA(${raController.text}) inválido."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NotFound - Facens'),
          backgroundColor: Colors.grey,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.school,
                    size: 100.0,
                  ),
                  const Text(
                    'O caminho para o sucesso começa aqui.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 50.0),
                  TextField(
                    controller: raController,
                    decoration: const InputDecoration(
                      labelText: 'Registro Academico',
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 6,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: showRA,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
