// ignore: file_names
import 'package:http/http.dart' as http;
import 'package:kayuhan_kulon/service/globalVar.dart';

class RegisterApi {
  String baseUrl = GlobalApi.getBaseUrl();

  Future registerUser(String? nama, String? role, String? password) async {
    Uri url = Uri.parse(baseUrl+'register');

    final response = await http.post(url, body: {
      "nama": nama,
      "role": role,
      "password": password,
    });
    if (response.statusCode == 200) {
      print("Data Added!");
      return true;
    } else {
      print("Falied Add Data!");
      return false;
    }
  }
}