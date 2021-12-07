// To parse this JSON data, do
//
//     final detailMasjidModel = detailMasjidModelFromJson(jsonString);

import 'dart:convert';

DetailMasjidModel detailMasjidModelFromJson(String str) => DetailMasjidModel.fromJson(json.decode(str));

class DetailMasjidModel {
  DetailMasjidModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory DetailMasjidModel.fromJson(Map<String, dynamic> json) => DetailMasjidModel(
    message: json["message"],
    results: Results.fromJson(json["results"]),
    code: json["code"],
  );
}

class Results {
  Results({
    this.id,
    this.nama,
    this.alamat,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.follow,
    this.profilMasjid,
  });

  int? id;
  String? nama;
  String? alamat;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? follow;
  ProfilMasjid? profilMasjid;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"],
    nama: json["nama"],
    alamat: json["alamat"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    follow: json["follow"],
    profilMasjid: ProfilMasjid.fromJson(json["profil_masjid"]),
  );
}

class ProfilMasjid {
  ProfilMasjid({
    this.id,
    this.idMasjid,
    this.tipe,
    this.luasTanah,
    this.statusTanah,
    this.luasBangunan,
    this.tahunBerdiri,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idMasjid;
  String? tipe;
  String? luasTanah;
  String? statusTanah;
  String? luasBangunan;
  String? tahunBerdiri;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProfilMasjid.fromJson(Map<String, dynamic> json) => ProfilMasjid(
    id: json["id"],
    idMasjid: json["id_masjid"],
    tipe: json["tipe"],
    luasTanah: json["luas_tanah"],
    statusTanah: json["status_tanah"],
    luasBangunan: json["luas_bangunan"],
    tahunBerdiri: json["tahun_berdiri"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
