import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/service/kegiatan_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'kegiatan_state.dart';

@injectable
class KegiatanCubit extends Cubit<KegiatanState> {
  final KegiatanService kegiatanService;
  KegiatanCubit(this.kegiatanService) : super(KegiatanInitial());
  KegiatanModel? model;
  late List<Result> data;
  String? id_masjid;
  Future init() async {
    try{
      emit(KegiatanLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if(this.id_masjid != null){
        model = await kegiatanService.getKegiatan(id_masjid ?? '');
      }
      emit(KegiatanLoaded());
    }catch (e){
      emit(KegiatanFailure(e.toString()));
    }
  }

  Future createKegiatan(Map data) async {
    this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
    data['id_masjid'] = id_masjid;
    final currentState = state;
    if(state is KegiatanLoaded){
      try{
        emit(KegiatanCreating());
        await kegiatanService.createKegiatan(data);
        emit(KegiatanCreated());
        emit(currentState);
      }catch (e){
        emit(KegiatanError(e.toString()));
        emit(currentState);
      }
    }
  }
  
  Future updateKegiatan(Map data) async {
    final currentState = state;
    if (state is KegiatanLoaded){
      try{
        emit(KegiatanUpdating());
        await kegiatanService.updateKegiatan(data);
        emit(KegiatanUpdated());
        emit(currentState);
      } catch (e){
        emit(KegiatanError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future deleteKegiatan(String _id) async {
    final currentState = state;
    if (state is KegiatanLoaded){
      try{
        emit(KegiatanDeleting());
        await kegiatanService.deleteKegiatan(_id);
        emit(KegiatanDeleted());
        emit(currentState);
      }catch (e){
        emit(KegiatanError(e.toString()));
        emit(currentState);
      }
    }
  }
}
