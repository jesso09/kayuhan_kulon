// To parse this JSON data, do
//
//     final kartuKeluarga = kartuKeluargaFromJson(jsonString);

import 'dart:convert';

List<KartuKeluarga> kartuKeluargaFromJson(String str) => List<KartuKeluarga>.from(json.decode(str).map((x) => KartuKeluarga.fromJson(x)));

String kartuKeluargaToJson(List<KartuKeluarga> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KartuKeluarga {
    int id;
    String idUser;
    String namaKepalaKeluarga;
    String alamat;
    String noKk;
    dynamic createdAt;
    dynamic updatedAt;

    KartuKeluarga({
        required this.id,
        required this.idUser,
        required this.namaKepalaKeluarga,
        required this.alamat,
        required this.noKk,
        this.createdAt,
        this.updatedAt,
    });

    factory KartuKeluarga.fromJson(Map<String, dynamic> json) => KartuKeluarga(
        id: json["id"],
        idUser: json["id_user"],
        namaKepalaKeluarga: json["nama_kepala_keluarga"],
        alamat: json["alamat"],
        noKk: json["no_kk"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "nama_kepala_keluarga": namaKepalaKeluarga,
        "alamat": alamat,
        "no_kk": noKk,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
