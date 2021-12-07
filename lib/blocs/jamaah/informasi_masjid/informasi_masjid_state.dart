part of 'informasi_masjid_cubit.dart';

abstract class InformasiMasjidState extends Equatable {
  const InformasiMasjidState();
  @override
  List<Object> get props => [];
}

class InformasiMasjidInitial extends InformasiMasjidState {}
class InformasiMasjidLoading extends InformasiMasjidState {}
class InformasiMasjidLoaded extends InformasiMasjidState {}
class InformasiMasjidFailure extends InformasiMasjidState {
  final String? message;

  InformasiMasjidFailure(this.message);
}
