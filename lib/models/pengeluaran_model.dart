// To parse this JSON data, do
//
//     final pengeluaranModel = pengeluaranModelFromJson(jsonString);

import 'dart:convert';

PengeluaranModel pengeluaranModelFromJson(String str) => PengeluaranModel.fromJson(json.decode(str));

class PengeluaranModel {
  PengeluaranModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory PengeluaranModel.fromJson(Map<String, dynamic> json) => PengeluaranModel(
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
    this.nominal,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idMasjid;
  String? nama;
  int? nominal;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    nama: json["nama"] == null ? null : json["nama"],
    nominal: json["nominal"] == null ? null : json["nominal"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
