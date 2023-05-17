import 'package:flutter/material.dart';

class MyMenuPage extends StatefulWidget {
  const MyMenuPage({super.key});

  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}
class _MyMenuPageState extends State<MyMenuPage> {

  void actionCanvas() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Canvas"),
      ),
    );
  }

  void actionMapa() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Mapa"),
      ),
    );
  }

  void actionAulas() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Aulas"),
      ),
    );
  }

  void actionAvisos() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Avisos"),
      ),
    );
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
                  const SizedBox(height: 100.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: actionCanvas,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Canvas'),
                      ),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: actionMapa,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Mapa'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: actionAulas,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Aulas'),
                      ),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: actionAvisos,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Avisos'),
                      ),
                    ],
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
