import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/service/jamaah_service.dart';
import 'package:smart_mosque/service/kegiatan_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'tambah_kegiatan_state.dart';

@injectable
class TambahKegiatanCubit extends Cubit<TambahKegiatanState> {
  final KegiatanService kegiatanService;
  final JamaahService jamaahService;
  TambahKegiatanCubit(this.kegiatanService, this.jamaahService) : super(TambahKegiatanInitial());
  JamaahListModel? jamaah;
  String? id_masjid;

  Future init() async {
    try{
      emit(TambahKegiatanLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      await Future.wait([getJamaah()]);
      emit(TambahKegiatanLoaded(jamaah:jamaah));
    }catch (e){
      emit(TambahKegiatanFailure(e.toString()));
    }
  }

  Future getJamaah() async {
    jamaah = await jamaahService.getJamaah(id_masjid!);
  }

  Future create(Map data) async{
    final currentState = state;
    if(state is TambahKegiatanLoaded){
      try{
        emit(TambahKegiatanCreating());
        data['id_masjid'] = id_masjid;
        await kegiatanService.createKegiatan(data);
        print(id_masjid);
        emit(TambahKegiatanCreated());
        emit(currentState);
      } catch (e){
        emit(TambahKegiatanError(e.toString()));
        emit(currentState);
      }
    }
  }
}
