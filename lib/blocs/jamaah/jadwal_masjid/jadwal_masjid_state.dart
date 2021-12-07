part of 'jadwal_masjid_cubit.dart';

abstract class JadwalMasjidState extends Equatable {
  const JadwalMasjidState();
  @override
  List<Object> get props => [];
}

class JadwalMasjidInitial extends JadwalMasjidState {}
class JadwalMasjidLoading extends JadwalMasjidState {}
class JadwalMasjidLoaded extends JadwalMasjidState {}
class JadwalMasjidFailure extends JadwalMasjidState {
  final String? message;

  JadwalMasjidFailure(this.message);
}
