import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMenuPage extends StatefulWidget {
  final Map<String, dynamic>? response;

  const MyMenuPage({Key? key, this.response}) : super(key: key);

  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}
class _MyMenuPageState extends State<MyMenuPage> {
  final Uri canvasUrl = Uri.parse('https://facens.instructure.com/');

  Future<bool> launchCanvas() async {
    if (!await launchUrl(canvasUrl)) {
      return false;
    }
    return true;
  }

  void actionCanvas() async {
    if (!await launchCanvas()){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possível acessar o Canvas."),
        ),
      );
    }
  }

  void actionMapa() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Mapa"),
      ),
    );
  }

  void actionAulas() {
    if (widget.response?['class']['status']) {
      String aula = widget.response?['class']['course'];
      String sala = widget.response?['class']['class'];
      String inicio = widget.response?['class']['start'];
      String fim = widget.response?['class']['end'];
      String professor = widget.response?['class']['teacher'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hoje, haverá uma aula de $aula na sala $sala nos horários de ($inicio - $fim) com o professor $professor."),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possível encontrar nenhuma aula para hoje."),
        ),
      );
    }
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
