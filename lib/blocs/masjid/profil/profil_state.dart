part of 'profil_cubit.dart';

abstract class ProfilState extends Equatable {
  const ProfilState();

  @override
  List<Object> get props => [];
}

class ProfilInitial extends ProfilState {}
class ProfilLoading extends ProfilState {}
class ProfilLoaded extends ProfilState {}
class ProfilFailure extends ProfilState {
  final String? message;

  ProfilFailure(this.message);
}

class ProfilUpdating extends ProfilState {}
class ProfilUpdated extends ProfilState {}
class ProfilError extends ProfilState {
  final String? message;

  ProfilError(this.message);
}
