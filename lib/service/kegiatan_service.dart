import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/service/http_service.dart';

@lazySingleton
class KegiatanService extends HttpService{
  Future getKegiatan(String id) async{
    Response response = await get('/masjid/kegiatan/$id');
    KegiatanModel kegiatanModel = kegiatanModelFromJson(jsonEncode(response.data));
    return kegiatanModel;
  }

  Future createKegiatan(Map data) async{
    await post('/masjid/kegiatan/create', data);
  }

  Future updateKegiatan(Map data) async{
    await post('/masjid/kegiatan/update', data);
  }

  Future deleteKegiatan(String id) async{
    await get('/masjid/kegiatan/delete/$id');
  }
}