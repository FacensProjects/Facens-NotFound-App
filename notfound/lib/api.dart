import 'package:http/http.dart' as http;
import 'dart:convert';

const String endSearch = "http://127.0.0.1:8000/api/v1/search/";

Future<Map<String, dynamic>?> searchRa(String ra) async {
  try {
    var response = await http.post(
      Uri.parse(endSearch),
      body: {"ra": ra},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  } catch (_) {
    return null;
  }
  return null;
}
