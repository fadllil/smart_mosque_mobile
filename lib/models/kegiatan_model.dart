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
    this.statusIuran,
    this.status,
    this.waktu,
    this.tanggal,
    this.createdAt,
    this.updatedAt,
    this.anggota,
    this.iuran,
  });

  int? id;
  int? idMasjid;
  String? nama;
  String? jenis;
  String? statusIuran;
  String? status;
  String? waktu;
  DateTime? tanggal;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Anggota>? anggota;
  List<Iuran>? iuran;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    nama: json["nama"] == null ? null : json["nama"],
    jenis: json["jenis"] == null ? null : json["jenis"],
    statusIuran: json["status_iuran"] == null ? null : json["status_iuran"],
    status: json["status"] == null ? null : json["status"],
    waktu: json["waktu"] == null ? null : json["waktu"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    anggota: json["anggota"] == null ? null : List<Anggota>.from(json["anggota"].map((x) => Anggota.fromJson(x))),
    iuran: json["iuran"] == null ? null : List<Iuran>.from(json["iuran"].map((x) => Iuran.fromJson(x))),
  );
}

class Anggota {
  Anggota({
    this.id,
    this.idKegiatan,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idKegiatan;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Anggota.fromJson(Map<String, dynamic> json) => Anggota(
    id: json["id"] == null ? null : json["id"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}

class Iuran {
  Iuran({
    this.id,
    this.idKegiatan,
    this.idUser,
    this.nominal,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idKegiatan;
  int? idUser;
  int? nominal;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Iuran.fromJson(Map<String, dynamic> json) => Iuran(
    id: json["id"] == null ? null : json["id"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    nominal: json["nominal"] == null ? null : json["nominal"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
