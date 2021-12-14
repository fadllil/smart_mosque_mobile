import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/service/jamaah_service.dart';
import 'package:smart_mosque/service/keuangan_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'tambah_pemasukan_state.dart';

@injectable
class TambahPemasukanCubit extends Cubit<TambahPemasukanState> {
  final KeuanganService keuanganService;
  final JamaahService jamaahService;
  TambahPemasukanCubit(this.keuanganService, this.jamaahService) : super(TambahPemasukanInitial());
  JamaahListModel? jamaah;
  String? id_masjid;

  Future init() async {
    try{
      emit(TambahPemasukanLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      await Future.wait([getJamaah()]);
      emit(TambahPemasukanLoaded(jamaah:jamaah));
    }catch (e){
      emit(TambahPemasukanFailure(e.toString()));
    }
  }

  Future getJamaah() async {
    jamaah = await jamaahService.getJamaah(id_masjid!);
  }

  Future create(Map data) async{
    final currentState = state;
    if(state is TambahPemasukanLoaded){
      try{
        emit(TambahPemasukanCreating());
        data['id_masjid'] = id_masjid;
        await keuanganService.createPemasukan(data);
        print(id_masjid);
        emit(TambahPemasukanCreated());
        emit(currentState);
      } catch (e){
        emit(TambahPemasukanError(e.toString()));
        emit(currentState);
      }
    }
  }
}
