import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/pengurus_model.dart';
import 'package:smart_mosque/service/http_service.dart';

@lazySingleton
class PengurusService extends HttpService{
  Future getPengurus(String id) async{
    Response response = await get('/masjid/pengurus/$id');
    PengurusModel pengurusModel = pengurusModelFromJson(jsonEncode(response.data));
    return pengurusModel;
  }

  Future postPengurus(Map data, String id)async{
    await post('/masjid/pengurus/create/$id', data);
  }

  Future updatePengurus(Map data) async{
    await post("/masjid/pengurus/update/", data);
  }

  Future deletePengurus(Map data) async{
    await post('/masjid/pengurus/delete', data);
  }
}