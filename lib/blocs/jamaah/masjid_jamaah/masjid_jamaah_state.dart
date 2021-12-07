part of 'masjid_jamaah_cubit.dart';

abstract class MasjidJamaahState extends Equatable {
  const MasjidJamaahState();

  @override
  List<Object> get props => [];
}

class MasjidJamaahInitial extends MasjidJamaahState {}
class MasjidJamaahLoading extends MasjidJamaahState {}
class MasjidJamaahLoaded extends MasjidJamaahState {}
class MasjidJamaahFailure extends MasjidJamaahState {
  final String? message;

  MasjidJamaahFailure(this.message);
}
