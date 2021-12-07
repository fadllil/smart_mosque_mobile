part of 'jadwal_imam_cubit.dart';

abstract class JadwalImamState extends Equatable {
  const JadwalImamState();

  @override
  List<Object> get props => [];
}

class JadwalImamInitial extends JadwalImamState {}
class JadwalImamLoading extends JadwalImamState {}
class JadwalImamLoaded extends JadwalImamState {}
class JadwalImamFailure extends JadwalImamState {
  final String? message;

  JadwalImamFailure(this.message);
}

class JadwalImamCreating extends JadwalImamState {}
class JadwalImamCreated extends JadwalImamState {}
class JadwalImamUpdating extends JadwalImamState {}
class JadwalImamUpdated extends JadwalImamState {}
class JadwalImamDeleting extends JadwalImamState {}
class JadwalImamDeleted extends JadwalImamState {}
class JadwalImamError extends JadwalImamState{
  final String? message;

  JadwalImamError(this.message);
}