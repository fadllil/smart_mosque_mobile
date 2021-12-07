import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/detail_jadwal_imam_model.dart';
import 'package:smart_mosque/models/detail_masjid_model.dart';
import 'package:smart_mosque/service/masjid_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'detail_masjid_state.dart';

@injectable
class DetailMasjidCubit extends Cubit<DetailMasjidState> {
  final MasjidService masjidService;
  DetailMasjidCubit(this.masjidService) : super(DetailMasjidInitial());
  DetailMasjidModel? model;
  bool follow = false;

  Future init(int id) async{
    try{
      emit(DetailMasjidLoading());
      model = await masjidService.getDetail(id.toString());
      emit(DetailMasjidLoaded());
    }catch (e){
      emit(DetailMasjidFailure(e.toString()));
    }
  }

  Future ikuti(Map data) async{
    try{
      emit(DetailMasjidCreating());
      data['id_user'] = await locator<PreferencesHelper>().getValue('id');
      model = await masjidService.postIkuti(data);
      emit(DetailMasjidCreated());
    }catch (e){
      emit(DetailMasjidError(e.toString()));
    }
  }
}
