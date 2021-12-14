// To parse this JSON data, do
//
//     final detailIuranModel = detailIuranModelFromJson(jsonString);

import 'dart:convert';

DetailIuranModel detailIuranModelFromJson(String str) => DetailIuranModel.fromJson(json.decode(str));

class DetailIuranModel {
  DetailIuranModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory DetailIuranModel.fromJson(Map<String, dynamic> json) => DetailIuranModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idKegiatan,
    this.idUser,
    this.nominal,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? idKegiatan;
  int? idUser;
  int? nominal;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    nominal: json["nominal"] == null ? null : json["nominal"],
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
