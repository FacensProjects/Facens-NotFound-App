import 'package:http/http.dart' as http;
import 'dart:convert';

const String endSearch = "http://10.0.2.2:8000/api/v1/search/";

Future<Map<String, dynamic>?> searchRa(String ra) async {
  try {
    var response = await http.post(
      Uri.parse(endSearch),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"ra": ra}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  } catch (e) {
    print('Ocorreu um erro: $e');
    return null;
  }
  return null;
}
