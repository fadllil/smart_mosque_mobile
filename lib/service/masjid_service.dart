import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/detail_masjid_model.dart';
import 'package:smart_mosque/models/masjid_list_model.dart';
import 'package:smart_mosque/service/http_service.dart';

@lazySingleton
class MasjidService extends HttpService{
  Future getAllMasjid() async{
    Response response = await get('/jamaah/masjid');
    MasjidListModel masjidListModel = masjidListModelFromJson(jsonEncode(response.data));
    return masjidListModel;
  }

  Future getMasjidDiikuti(String id) async{
    Response response = await get('/jamaah/masjid/diikuti/$id');
    MasjidListModel masjidListModel = masjidListModelFromJson(jsonEncode(response.data));
    return masjidListModel;
  }

  Future getDetail(String id) async{
    Response response = await get('/jamaah/masjid/detail/$id');
    DetailMasjidModel detailMasjidModel = detailMasjidModelFromJson(jsonEncode(response.data));
    return detailMasjidModel;
  }

  Future postIkuti(Map data) async{
    await post('/jamaah/masjid/ikuti', data);
  }

  Future updateDetail(Map data) async{
    await post('/masjid/detail/update', data);
  }
}