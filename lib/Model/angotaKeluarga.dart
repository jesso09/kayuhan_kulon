// To parse this JSON data, do
//
//     final anggotaKeluarga = anggotaKeluargaFromJson(jsonString);

import 'dart:convert';

AnggotaKeluarga anggotaKeluargaFromJson(String str) => AnggotaKeluarga.fromJson(json.decode(str));

String anggotaKeluargaToJson(AnggotaKeluarga data) => json.encode(data.toJson());

class AnggotaKeluarga {
    int id;
    String idKk;
    String nik;
    String namaLengkap;
    String jenisKelamin;
    String tempatLahir;
    DateTime tanggalLahir;
    String agama;
    DateTime createdAt;
    DateTime updatedAt;
    KartuKeluarga kartuKeluarga;

    AnggotaKeluarga({
        required this.id,
        required this.idKk,
        required this.nik,
        required this.namaLengkap,
        required this.jenisKelamin,
        required this.tempatLahir,
        required this.tanggalLahir,
        required this.agama,
        required this.createdAt,
        required this.updatedAt,
        required this.kartuKeluarga,
    });

    factory AnggotaKeluarga.fromJson(Map<String, dynamic> json) => AnggotaKeluarga(
        id: json["id"],
        idKk: json["id_kk"],
        nik: json["nik"],
        namaLengkap: json["nama_lengkap"],
        jenisKelamin: json["jenis_kelamin"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        agama: json["agama"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        kartuKeluarga: KartuKeluarga.fromJson(json["kartu_keluarga"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_kk": idKk,
        "nik": nik,
        "nama_lengkap": namaLengkap,
        "jenis_kelamin": jenisKelamin,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
        "agama": agama,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "kartu_keluarga": kartuKeluarga.toJson(),
    };
}

class KartuKeluarga {
    int id;
    String idUser;
    String namaKepalaKeluarga;
    String alamat;
    String noKk;
    DateTime createdAt;
    DateTime updatedAt;

    KartuKeluarga({
        required this.id,
        required this.idUser,
        required this.namaKepalaKeluarga,
        required this.alamat,
        required this.noKk,
        required this.createdAt,
        required this.updatedAt,
    });

    factory KartuKeluarga.fromJson(Map<String, dynamic> json) => KartuKeluarga(
        id: json["id"],
        idUser: json["id_user"],
        namaKepalaKeluarga: json["nama_kepala_keluarga"],
        alamat: json["alamat"],
        noKk: json["no_kk"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "nama_kepala_keluarga": namaKepalaKeluarga,
        "alamat": alamat,
        "no_kk": noKk,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
