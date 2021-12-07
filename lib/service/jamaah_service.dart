import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/models/masjid_list_model.dart';
import 'package:smart_mosque/service/http_service.dart';

@lazySingleton
class JamaahService extends HttpService{
  Future getJamaah(String id) async{
    Response response = await get('/masjid/jamaah/$id');
    JamaahListModel jamaahListModel = jamaahListModelFromJson(jsonEncode(response.data));
    return jamaahListModel;
  }
}