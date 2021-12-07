// To parse this JSON data, do
//
//     final detailJadwalImamModel = detailJadwalImamModelFromJson(jsonString);

import 'dart:convert';

DetailJadwalImamModel detailJadwalImamModelFromJson(String str) => DetailJadwalImamModel.fromJson(json.decode(str));

class DetailJadwalImamModel {
  DetailJadwalImamModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory DetailJadwalImamModel.fromJson(Map<String, dynamic> json) => DetailJadwalImamModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idJadwalImam: json["id_jadwal_imam"] == null ? null : json["id_jadwal_imam"],
    jadwal: json["jadwal"] == null ? null : json["jadwal"],
    nama: json["nama"] == null ? null : json["nama"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
