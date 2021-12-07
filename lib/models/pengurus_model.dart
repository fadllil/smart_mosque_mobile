// To parse this JSON data, do
//
//     final pengurusModel = pengurusModelFromJson(jsonString);

import 'dart:convert';

PengurusModel pengurusModelFromJson(String str) => PengurusModel.fromJson(json.decode(str));

class PengurusModel {
  PengurusModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory PengurusModel.fromJson(Map<String, dynamic> json) => PengurusModel(
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
    this.jabatan,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idMasjid;
  String? nama;
  String? jabatan;
  String? alamat;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    nama: json["nama"] == null ? null : json["nama"],
    jabatan: json["jabatan"] == null ? null : json["jabatan"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
