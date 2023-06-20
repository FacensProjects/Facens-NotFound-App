import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notfound/api.dart' show searchRa;
import 'package:notfound/mapa.dart' show MyMapaPage;

// ignore: must_be_immutable
class MyMenuPage extends StatefulWidget {
  Map<String, dynamic> response;
  String ra;

  MyMenuPage({Key? key, required this.response, required this.ra})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyMenuPageState createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  final Uri canvasUrl = Uri.parse('https://facens.instructure.com/');

  Future<bool> updateResponse() async {
    try {
      var tempResponse = await searchRa(widget.ra);
      if (tempResponse?['status']) {
        widget.response = tempResponse!;
        return true;
      }
    } finally {
      // ignore: control_flow_in_finally
      return false;
    }
  }

  Future<bool> launchCanvas() async {
    if (!await launchUrl(canvasUrl)) {
      return false;
    }
    return true;
  }

  void actionCanvas() async {
    await updateResponse();
    if (!await launchCanvas()) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possível acessar o Canvas."),
        ),
      );
    }
    setState(() {});
  }

  void actionMapa() async {
    await updateResponse();
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyMapaPage(
              location: widget.response['class']['location'] ?? 'default')),
    );
    setState(() {});
  }

  void actionAulas() async {
    await updateResponse();
    if (widget.response['class']['status'] ?? false) {
      String curso = widget.response['class']['course'] ?? '';
      String aula = widget.response['class']['course'] ??
          ''; // widget.response?['class']['name'] ?? '';
      String sala = widget.response['class']['class'] ?? '';
      String inicio = widget.response['class']['start'] ?? '';
      String fim = widget.response['class']['end'] ?? '';
      String professor = widget.response['class']['teacher'] ?? '';
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(curso),
            content: Text(
                'Hoje, haverá uma aula de $aula na sala $sala nos horários de ($inicio - $fim) com o professor $professor.'),
            actions: [
              TextButton(
                child: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('NotFound - Facens'),
            content: const Text(
                'Não foi possível encontrar nenhuma aula para hoje.'),
            actions: [
              TextButton(
                child: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    setState(() {});
  }

  void actionAvisos() async {
    await updateResponse();
    if ((widget.response['class']['notification'] ?? []).isNotEmpty) {
      for (var notification in widget.response['class']['notification']) {
        String titulo = notification['title'] ?? '';
        String professor = notification['teacher'] ?? '';
        String descricao = notification['description'] ?? '';
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(titulo),
              content: Text('$professor: $descricao'),
              actions: [
                TextButton(
                  child: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('NotFound - Facens'),
            content: const Text(
                'Não foi possível encontrar nenhum aviso para hoje.'),
            actions: [
              TextButton(
                child: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NotFound - Facens'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                      'images/${widget.response['class']['location'] ?? 'default'}.png'),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: actionCanvas,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(125, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurpleAccent[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Canvas'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: actionMapa,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(125, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurpleAccent[600],
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
                          fixedSize: const Size(125, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurpleAccent[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Aulas'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: actionAvisos,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(125, 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple[600],
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
