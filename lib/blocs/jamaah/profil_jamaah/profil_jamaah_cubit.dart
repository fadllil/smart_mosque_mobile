import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/profil_jamaah_model.dart';
import 'package:smart_mosque/service/profil_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'profil_jamaah_state.dart';

@injectable
class ProfilJamaahCubit extends Cubit<ProfilJamaahState> {
  final ProfilService profilService;
  ProfilJamaahCubit(this.profilService) : super(ProfilJamaahInitial());
  late ProfilJamaahModel profilJamaahModel;
  String? id;

  Future init() async {
    try{
      emit(ProfilJamaahLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      profilJamaahModel = await profilService.getProfilJamaah(id!);
      emit(ProfilJamaahLoaded());
    }catch (e){
      // print(profilModel);
      emit(ProfilJamaahFailure(e.toString()));
    }
  }

  Future update(Map data) async{
    try{
      emit(ProfilJamaahUpdating());
      await profilService.updateProfilJamaah(data);
      await locator<PreferencesHelper>().storeValueString('nama', data['nama']);
      emit(ProfilJamaahUpdated());
      await init();
    }catch (e){
      emit(ProfilJamaahError(e.toString()));
    }
  }
}
