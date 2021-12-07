import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/blocs/masjid/jamaah/jamaah_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/pengurus_model.dart';
import 'package:smart_mosque/service/pengurus_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';
import '../../../view/masjid/pengurus/pengurus.dart';

part 'pengurus_state.dart';
@injectable
class PengurusCubit extends Cubit<PengurusState> {
  final PengurusService pengurusService;
  PengurusCubit(this.pengurusService) : super(PengurusInitial());
  PengurusModel? model;
  late List<Result> data;
  String? id_masjid;
  Future init() async{
    try{
      emit(PengurusLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if(this.id_masjid != null){
        model = await pengurusService.getPengurus(id_masjid ?? '');
      }
      emit(PengurusLoaded());
    }catch (e){
      emit(PengurusFailure(e.toString()));
    }
  }

  Future updatePengurus(Map data) async {
    final currentState = state;
    if(state is PengurusLoaded){
      try{
        emit(PengurusCreating());
        await pengurusService.updatePengurus(data);
        emit(PengurusCreated());
        emit(currentState);
      }catch (e){
        emit(PengurusError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future deletePengurus(Map data) async{
    final currentState = state;
    if(state is PengurusLoaded){
      try{
        emit(PengurusDeleting());
        await pengurusService.deletePengurus(data);
        emit(PengurusDeleted());
        emit(currentState);
      } catch (e){
        emit(PengurusError(e.toString()));
        emit(currentState);
      }
    }
  }
}
