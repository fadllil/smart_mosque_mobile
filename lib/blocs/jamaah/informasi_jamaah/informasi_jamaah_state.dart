part of 'informasi_jamaah_cubit.dart';

abstract class InformasiJamaahState extends Equatable {
  const InformasiJamaahState();

  @override
  List<Object> get props => [];
}

class InformasiJamaahInitial extends InformasiJamaahState {}
class InformasiJamaahLoading extends InformasiJamaahState {}
class InformasiJamaahLoaded extends InformasiJamaahState {}
class InformasiJamaahFailure extends InformasiJamaahState {
  final String? message;

  InformasiJamaahFailure(this.message);
}
