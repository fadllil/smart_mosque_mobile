import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/detail_masjid_model.dart';
import 'package:smart_mosque/service/masjid_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'detail_state.dart';

@injectable
class DetailCubit extends Cubit<DetailState> {
  final MasjidService masjidService;
  DetailCubit(this.masjidService) : super(DetailInitial());
  DetailMasjidModel? model;
  String? id;
  bool follow = false;

  Future init() async{
    try{
      emit(DetailLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_masjid');
      model = await masjidService.getDetail(id!);
      emit(DetailLoaded());
    }catch (e){
      emit(DetailFailure(e.toString()));
    }
  }

  Future update(Map data) async {
    try{
      emit(DetailUpdating());
      model = await masjidService.updateDetail(data);
      emit(DetailUpdated());
    }catch (e){
      emit(DetailError(e.toString()));
    }
  }
}
