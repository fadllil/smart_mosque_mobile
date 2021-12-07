import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/inventaris_model.dart';

import 'http_service.dart';

@lazySingleton
class InventarisService extends HttpService {
  Future getInventaris(String id) async {
    Response response = await get('/masjid/inventaris/$id');
    InventarisModel inventarisModel = inventarisModelFromJson(
        jsonEncode(response.data));
    return inventarisModel;
  }

  Future createInventaris(Map data) async{
    await post('/masjid/inventaris/create', data);
  }

  Future updateInventaris(Map data) async{
    await post('/masjid/inventaris/update', data);
  }

  Future deleteInventaris(String id) async{
    await get('/masjid/inventaris/delete/$id');
  }
}