// To parse this JSON data, do
//
//     final profilModel = profilModelFromJson(jsonString);

import 'dart:convert';

ProfilModel profilModelFromJson(String str) => ProfilModel.fromJson(json.decode(str));

class ProfilModel {
  ProfilModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory ProfilModel.fromJson(Map<String, dynamic> json) => ProfilModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
    code: json["code"] == null ? null : json["code"],
  );
}

class Results {
  Results({
    this.id,
    this.nama,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.adminMasjid,
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  AdminMasjid? adminMasjid;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    adminMasjid: json["admin_masjid"] == null ? null : AdminMasjid.fromJson(json["admin_masjid"]),
  );
}

class AdminMasjid {
  AdminMasjid({
    this.id,
    this.idUser,
    this.idMasjid,
    this.noHp,
    this.alamat,
    this.jabatan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idUser;
  int? idMasjid;
  String? noHp;
  String? alamat;
  String? jabatan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AdminMasjid.fromJson(Map<String, dynamic> json) => AdminMasjid(
    id: json["id"] == null ? null : json["id"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    jabatan: json["jabatan"] == null ? null : json["jabatan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
