// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.code,
    this.results,
    this.message,
  });

  int? code;
  String? results;
  String? message;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    code: json["code"] == null ? null : json["code"],
    results: json["results"] == null ? null : json["results"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "results": results == null ? null : results,
    "message": message == null ? null : message,
  };
}
