// To parse this JSON data, do
//
//     final inventarisModel = inventarisModelFromJson(jsonString);

import 'dart:convert';

InventarisModel inventarisModelFromJson(String str) => InventarisModel.fromJson(json.decode(str));

class InventarisModel {
  InventarisModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory InventarisModel.fromJson(Map<String, dynamic> json) => InventarisModel(
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
    this.jumlah,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idMasjid;
  String? nama;
  int? jumlah;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    nama: json["nama"] == null ? null : json["nama"],
    jumlah: json["jumlah"] == null ? null : json["jumlah"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
