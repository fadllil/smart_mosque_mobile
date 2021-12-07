// To parse this JSON data, do
//
//     final jadwalImamModel = jadwalImamModelFromJson(jsonString);

import 'dart:convert';

JadwalImamModel jadwalImamModelFromJson(String str) => JadwalImamModel.fromJson(json.decode(str));

class JadwalImamModel {
  JadwalImamModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory JadwalImamModel.fromJson(Map<String, dynamic> json) => JadwalImamModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idMasjid,
    this.hari,
    this.createdAt,
    this.updatedAt,
    this.detailImam,
  });

  int? id;
  int? idMasjid;
  String? hari;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<DetailImam>? detailImam;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    hari: json["hari"] == null ? null : json["hari"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    detailImam: json["detail_imam"] == null ? null : List<DetailImam>.from(json["detail_imam"].map((x) => DetailImam.fromJson(x))),
  );
}

class DetailImam {
  DetailImam({
    this.id,
    this.idJadwalImam,
    this.jadwal,
    this.nama,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idJadwalImam;
  String? jadwal;
  String? nama;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DetailImam.fromJson(Map<String, dynamic> json) => DetailImam(
    id: json["id"] == null ? null : json["id"],
    idJadwalImam: json["id_jadwal_imam"] == null ? null : json["id_jadwal_imam"],
    jadwal: json["jadwal"] == null ? null : json["jadwal"],
    nama: json["nama"] == null ? null : json["nama"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
