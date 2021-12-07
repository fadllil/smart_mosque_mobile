part of 'pemasukan_masjid_cubit.dart';

abstract class PemasukanMasjidState extends Equatable {
  const PemasukanMasjidState();
  @override
  List<Object> get props => [];
}

class PemasukanMasjidInitial extends PemasukanMasjidState {}
class PemasukanMasjidLoading extends PemasukanMasjidState {}
class PemasukanMasjidLoaded extends PemasukanMasjidState {}
class PemasukanMasjidFailure extends PemasukanMasjidState {
  final String? message;

  PemasukanMasjidFailure(this.message);
}
