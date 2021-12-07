// To parse this JSON data, do
//
//     final jwtModel = jwtModelFromJson(jsonString);

import 'dart:convert';

JwtModel jwtModelFromJson(String str) => JwtModel.fromJson(json.decode(str));

class JwtModel {
  JwtModel({
    this.iss,
    this.sub,
    this.iat,
  });

  String? iss;
  Sub? sub;
  int? iat;

  factory JwtModel.fromJson(Map<String, dynamic> json) => JwtModel(
    iss: json["iss"] == null ? null : json["iss"],
    sub: json["sub"] == null ? null : Sub.fromJson(json["sub"]),
    iat: json["iat"] == null ? null : json["iat"],
  );
}

class Sub {
  Sub({
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

  factory Sub.fromJson(Map<String, dynamic> json) => Sub(
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
