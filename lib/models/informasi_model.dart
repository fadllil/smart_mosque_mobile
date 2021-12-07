// To parse this JSON data, do
//
//     final informasiModel = informasiModelFromJson(jsonString);

import 'dart:convert';

InformasiModel informasiModelFromJson(String str) => InformasiModel.fromJson(json.decode(str));

class InformasiModel {
  InformasiModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory InformasiModel.fromJson(Map<String, dynamic> json) => InformasiModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idMasjid,
    this.judul,
    this.isi,
    this.tanggal,
    this.waktu,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idMasjid;
  String? judul;
  String? isi;
  DateTime? tanggal;
  String? waktu;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    judul: json["judul"] == null ? null : json["judul"],
    isi: json["isi"] == null ? null : json["isi"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    waktu: json["waktu"] == null ? null : json["waktu"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
