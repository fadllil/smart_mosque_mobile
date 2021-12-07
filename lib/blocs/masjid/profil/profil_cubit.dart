import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/profil_model.dart';
import 'package:smart_mosque/service/profil_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'profil_state.dart';

@injectable
class ProfilCubit extends Cubit<ProfilState> {
  final ProfilService profilService;
  ProfilCubit(this.profilService) : super(ProfilInitial());
  late ProfilModel profilModel;
  String? id;

  Future init() async {
    try{
      emit(ProfilLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      profilModel = await profilService.getProfil(id!);
      emit(ProfilLoaded());
    }catch (e){
      // print(profilModel);
      emit(ProfilFailure(e.toString()));
    }
  }

  Future update(Map data) async{
    try{
      emit(ProfilUpdating());
      await profilService.updateProfil(data);
      await locator<PreferencesHelper>().storeValueString('nama', data['nama']);
      emit(ProfilUpdated());
      await init();
    }catch (e){
      emit(ProfilError(e.toString()));
    }
  }
}
