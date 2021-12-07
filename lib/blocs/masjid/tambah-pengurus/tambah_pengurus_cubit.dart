import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/service/pengurus_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'tambah_pengurus_state.dart';

@injectable
class TambahPengurusCubit extends Cubit<TambahPengurusState> {
  final PengurusService pengurusService;
  TambahPengurusCubit(this.pengurusService) : super(TambahPengurusInitial());
  String? id_masjid;
  Future init() async{
    try{
      emit(TambahPengurusLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      emit(TambahPengurusLoaded());
    } catch (e){
      emit(TambahPengurusFailure(e.toString()));
    }
  }

  Future postPengurus(Map data) async{
    final currentState = state;
    if(state is TambahPengurusLoaded){
      try{
        emit(TambahPengurusCreating());
        await pengurusService.postPengurus(data, id_masjid!);
        print(id_masjid);
        emit(TambahPengurusCreated());
        emit(currentState);
      } catch (e){
        emit(TambahPengurusError(e.toString()));
        emit(currentState);
      }
    }
  }
}
