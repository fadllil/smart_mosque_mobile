part of 'pengeluaran_masjid_cubit.dart';

abstract class PengeluaranMasjidState extends Equatable {
  const PengeluaranMasjidState();
  @override
  List<Object> get props => [];
}

class PengeluaranMasjidInitial extends PengeluaranMasjidState {}
class PengeluaranMasjidLoading extends PengeluaranMasjidState {}
class PengeluaranMasjidLoaded extends PengeluaranMasjidState {}
class PengeluaranMasjidFailure extends PengeluaranMasjidState {
  final String? message;

  PengeluaranMasjidFailure(this.message);
}
