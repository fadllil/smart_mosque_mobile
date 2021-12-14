// To parse this JSON data, do
//
//     final detailAnggotaModel = detailAnggotaModelFromJson(jsonString);

import 'dart:convert';

DetailAnggotaModel detailAnggotaModelFromJson(String str) => DetailAnggotaModel.fromJson(json.decode(str));

class DetailAnggotaModel {
  DetailAnggotaModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory DetailAnggotaModel.fromJson(Map<String, dynamic> json) => DetailAnggotaModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
    code: json["code"] == null ? null : json["code"],
  );
}

class Results {
  Results({
    this.id,
    this.idKegiatan,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.detailAnggota,
  });

  int? id;
  int? idKegiatan;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<DetailAnggota>? detailAnggota;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"] == null ? null : json["id"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    detailAnggota: json["detail_anggota"] == null ? null : List<DetailAnggota>.from(json["detail_anggota"].map((x) => DetailAnggota.fromJson(x))),
  );
}

class DetailAnggota {
  DetailAnggota({
    this.id,
    this.idKegiatanAnggota,
    this.idUser,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? idKegiatanAnggota;
  int? idUser;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory DetailAnggota.fromJson(Map<String, dynamic> json) => DetailAnggota(
    id: json["id"] == null ? null : json["id"],
    idKegiatanAnggota: json["id_kegiatan_anggota"] == null ? null : json["id_kegiatan_anggota"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );
}

class User {
  User({
    this.id,
    this.nama,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
