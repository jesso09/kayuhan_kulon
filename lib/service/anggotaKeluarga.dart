// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kayuhan_kulon/Model/angotaKeluarga.dart';
import 'globalVar.dart';

class AnggotaKeluargaApi{
  String baseUrl = GlobalApi.getBaseUrl();
  String pathApi = 'anggota_keluarga';

  Future<List<AnggotaKeluarga>> getData(int id_kk) async {
    Uri url = Uri.parse(baseUrl + pathApi+'/'+ id_kk.toString());

    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body) as Map<String, dynamic>;
      var dataAnggotaKK = responseData['data'] as List<dynamic>;

      List<AnggotaKeluarga> anggotaKK = dataAnggotaKK
          .map<AnggotaKeluarga>(
              (tempdataAnggotaKK) => AnggotaKeluarga.fromJson(tempdataAnggotaKK))
          .toList();
      return anggotaKK;
    } else if (response.statusCode == 0) {
      throw Exception('Failed to connect to ' + baseUrl);
    } else {
      throw Exception(response.body);
    }
  }

  Future tambahData(int id_user, String? nama_kepala_keluarga, String? alamat, String? no_kk) async {
    Uri url = Uri.parse(baseUrl + pathApi);

    // String formattedDate = DateFormat('yyyy-MM-dd').format(tglLahir);
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
