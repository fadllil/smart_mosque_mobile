// To parse this JSON data, do
//
//     final masjidListModel = masjidListModelFromJson(jsonString);

import 'dart:convert';

MasjidListModel masjidListModelFromJson(String str) => MasjidListModel.fromJson(json.decode(str));

class MasjidListModel {
  MasjidListModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory MasjidListModel.fromJson(Map<String, dynamic> json) => MasjidListModel(
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.nama,
    this.alamat,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.profilMasjid,
  });

  int? id;
  String? nama;
  String? alamat;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProfilMasjid? profilMasjid;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    nama: json["nama"],
    alamat: json["alamat"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
