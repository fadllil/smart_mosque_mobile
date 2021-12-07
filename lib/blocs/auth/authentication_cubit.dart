import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/jwt_model.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  Future appStarted() async {
    try{
      emit(AuthenticationLoading());
      String? token = await locator<PreferencesHelper>().getValue('token');
      if(token != null){
        JwtModel jwtModel = jwtModelFromJson(ascii.decode(base64.decode(base64.normalize(token.split('.')[1]))));
        await locator<PreferencesHelper>().storeValueString('id', jwtModel.sub!.id!.toString());
        await locator<PreferencesHelper>().storeValueString('role', jwtModel.sub!.role!);
        await locator<PreferencesHelper>().storeValueString('nama', jwtModel.sub!.nama!);
        if(jwtModel.sub!.role! == 'Masjid'){
          await locator<PreferencesHelper>().storeValueString('id_masjid', jwtModel.sub!.adminMasjid!.idMasjid!.toString());
        }
        emit(AuthenticationAuthenticated(token: token, role: jwtModel.sub!.role!));
      }else{
        emit(AuthenticationUnauthenticated());
      }
    }catch (e){
      emit(AuthenticationFailure(message: e.toString()));
    }
  }
  Future logout() async{
    try{
      emit(AuthenticationLoading());
      await locator<PreferencesHelper>().deleteAll();
      emit(AuthenticationUnauthenticated());
    }catch (_){
      emit(AuthenticationFailure(message: 'Terjadi kesalahan, cek koneksi internet anda'));
    }
  }
}
