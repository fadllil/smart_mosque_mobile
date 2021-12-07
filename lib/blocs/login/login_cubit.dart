import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/blocs/auth/authentication_cubit.dart';
import 'package:smart_mosque/service/login_service.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginService loginService;
  final AuthenticationCubit authenticationCubit;
  LoginCubit(this.loginService, this.authenticationCubit) : super(LoginInitial());
  Future login(String email, String password) async {
    try{
      emit(LoginLoading());
      await loginService.login(email, password);
      emit(LoginSuccess());
      await authenticationCubit.appStarted();
    } catch (e){
      emit(LoginFailure(message: e.toString()));
    }
  }
}
