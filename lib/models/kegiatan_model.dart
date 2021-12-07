// To parse this JSON data, do
//
//     final kegiatanModel = kegiatanModelFromJson(jsonString);

import 'dart:convert';

KegiatanModel kegiatanModelFromJson(String str) => KegiatanModel.fromJson(json.decode(str));

class KegiatanModel {
  KegiatanModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory KegiatanModel.fromJson(Map<String, dynamic> json) => KegiatanModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idMasjid,
    this.nama,
    this.jenis,
    this.waktu,
    this.tanggal,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idMasjid;
  String? nama;
  String? jenis;
  String? waktu;
  DateTime? tanggal;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    nama: json["nama"] == null ? null : json["nama"],
    jenis: json["jenis"] == null ? null : json["jenis"],
    waktu: json["waktu"] == null ? null : json["waktu"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
