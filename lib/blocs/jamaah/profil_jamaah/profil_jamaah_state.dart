part of 'profil_jamaah_cubit.dart';

abstract class ProfilJamaahState extends Equatable {
  const ProfilJamaahState();
  @override
  List<Object> get props => [];
}

class ProfilJamaahInitial extends ProfilJamaahState {}
class ProfilJamaahLoading extends ProfilJamaahState {}
class ProfilJamaahLoaded extends ProfilJamaahState {}
class ProfilJamaahFailure extends ProfilJamaahState {
  final String? message;

  ProfilJamaahFailure(this.message);
}

class ProfilJamaahUpdating extends ProfilJamaahState {}
class ProfilJamaahUpdated extends ProfilJamaahState {}
class ProfilJamaahError extends ProfilJamaahState {
  final String? message;

  ProfilJamaahError(this.message);
}
