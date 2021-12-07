import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/service/jamaah_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'jamaah_state.dart';
@injectable
class JamaahCubit extends Cubit<JamaahState> {
  final JamaahService jamaahService;
  JamaahCubit(this.jamaahService) : super(JamaahInitial());
  JamaahListModel? model;
  late List<Result> data;
  String? id_masjid;
  Future init() async{
    try{
      emit(JamaahLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if (this.id_masjid!=null){
        model = await jamaahService.getJamaah(id_masjid ?? '');
      }
      emit(JamaahLoaded());
    }catch (e){
      emit(JamaahFailure(e.toString()));
    }
  }
}
