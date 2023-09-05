import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/kartuKeluarga.dart';
import 'globalVar.dart';

class KartuKeluargaApi {
  String baseUrl = GlobalApi.getBaseUrl();
  String pathApi = 'kartu_keluarga';

  Future<List<KartuKeluarga>> getDataKeluarga(int id_user) async {
    Uri url = Uri.parse(baseUrl + pathApi+'/'+ id_user.toString());

    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body) as Map<String, dynamic>;
      var dataKeluarga = responseData['data'] as List<dynamic>;

      List<KartuKeluarga> kartuKeluarga = dataKeluarga
          .map<KartuKeluarga>(
              (tempDataKeluarga) => KartuKeluarga.fromJson(tempDataKeluarga))
          .toList();
      return kartuKeluarga;
    } else if (response.statusCode == 0) {
      throw Exception('Failed to connect to ' + baseUrl);
    } else {
      throw Exception('Failed get data member');
    }
  }

  Future tambahData(int id_user, String? nama_kepala_keluarga, String? alamat, String? no_kk) async {
    Uri url = Uri.parse(baseUrl + pathApi);

    final response = await http.post(url, body: {
      "id_user": id_user.toString(),
      "nama_kepala_keluarga": nama_kepala_keluarga,
      "alamat": alamat,
      "no_kk": no_kk,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    final url = Uri.parse(baseUrl + pathApi +'/' + id);

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
