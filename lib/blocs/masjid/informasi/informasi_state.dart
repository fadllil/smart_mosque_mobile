part of 'informasi_cubit.dart';

abstract class InformasiState extends Equatable {
  const InformasiState();

  @override
  List<Object> get props => [];
}

class InformasiInitial extends InformasiState {}
class InformasiLoading extends InformasiState {}
class InformasiLoaded extends InformasiState {}
class InformasiFailure extends InformasiState {
  final String? message;

  InformasiFailure(this.message);
}

class InformasiCreating extends InformasiState {}
class InformasiCreated extends InformasiState {}
class InformasiUpdating extends InformasiState {}
class InformasiUpdated extends InformasiState {}
class InformasiDeleting extends InformasiState {}
class InformasiDeleted extends InformasiState {}
class InformasiError extends InformasiState {
  final String? message;

  InformasiError(this.message);
}
