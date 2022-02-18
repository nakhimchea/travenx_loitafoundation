import 'package:http/http.dart' as http;

class InternetService {
  static Future<String> httpGetResponseBody({required String url}) async {
    http.Response response = await http.get(Uri.parse(url)).catchError((e) {
      print('Request failed: $e');
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Response Status Code: ${response.statusCode}');
      return '';
    }
  }
}
