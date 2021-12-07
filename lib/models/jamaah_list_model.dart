// To parse this JSON data, do
//
//     final jamaahListModel = jamaahListModelFromJson(jsonString);

import 'dart:convert';

JamaahListModel jamaahListModelFromJson(String str) => JamaahListModel.fromJson(json.decode(str));

class JamaahListModel {
  JamaahListModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory JamaahListModel.fromJson(Map<String, dynamic> json) => JamaahListModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idUser,
    this.idMasjid,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.jamaah,
  });

  int? id;
  int? idUser;
  int? idMasjid;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  Jamaah? jamaah;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    idMasjid: json["id_masjid"] == null ? null : json["id_masjid"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    jamaah: json["jamaah"] == null ? null : Jamaah.fromJson(json["jamaah"]),
  );
}

class Jamaah {
  Jamaah({
    this.id,
    this.idUser,
    this.noHp,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idUser;
  String? noHp;
  String? alamat;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Jamaah.fromJson(Map<String, dynamic> json) => Jamaah(
    id: json["id"] == null ? null : json["id"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
