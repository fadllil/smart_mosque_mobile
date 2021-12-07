part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticationAuthenticated extends AuthenticationState{
  final String? token;
  final String? role;
  AuthenticationAuthenticated({this.token, this.role});
}
class AuthenticationUnauthenticated extends AuthenticationState {}
class AuthenticationFailure extends AuthenticationState {
  final String? message;
  AuthenticationFailure({this.message});
}
