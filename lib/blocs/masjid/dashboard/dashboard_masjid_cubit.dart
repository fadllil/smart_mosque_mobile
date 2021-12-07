import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'dashboard_masjid_state.dart';

@injectable
class DashboardMasjidCubit extends Cubit<DashboardMasjidState> {
  DashboardMasjidCubit() : super(DashboardMasjidInitial());
  Future init() async{
    try{
      emit(DashboardMasjidLoading());
      String nama = await locator<PreferencesHelper>().getValue('nama');
      emit(DashboardMasjidLoaded(nama: nama));
    }catch (e){
      emit(DashboardMasjidFailure(e.toString()));
    }
  }
}
