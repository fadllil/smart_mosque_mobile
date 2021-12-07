// To parse this JSON data, do
//
//     final informasiJamaahModel = informasiJamaahModelFromJson(jsonString);

import 'dart:convert';

InformasiJamaahModel informasiJamaahModelFromJson(String str) => InformasiJamaahModel.fromJson(json.decode(str));

class InformasiJamaahModel {
  InformasiJamaahModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory InformasiJamaahModel.fromJson(Map<String, dynamic> json) => InformasiJamaahModel(
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"],
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
    this.nama,
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
  String? nama;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    idMasjid: json["id_masjid"],
    judul: json["judul"],
    isi: json["isi"],
    tanggal: DateTime.parse(json["tanggal"]),
    waktu: json["waktu"],
    keterangan: json["keterangan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    nama: json["nama"],
  );
}
