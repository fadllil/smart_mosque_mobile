part of 'detail_imam_cubit.dart';

abstract class DetailImamState extends Equatable {
  const DetailImamState();
  @override
  List<Object> get props => [];
}

class DetailImamInitial extends DetailImamState {}
class DetailImamLoading extends DetailImamState {}
class DetailImamLoaded extends DetailImamState {
  final int? idDetail;

  DetailImamLoaded({this.idDetail});
}
class DetailImamFailure extends DetailImamState {
  final String? message;

  DetailImamFailure(this.message);
}

class DetailImamCreating extends DetailImamState {}
class DetailImamCreated extends DetailImamState {}
class DetailImamUpdating extends DetailImamState {}
class DetailImamUpdated extends DetailImamState {}
class DetailImamDeleting extends DetailImamState {}
class DetailImamDeleted extends DetailImamState {}
class DetailImamError extends DetailImamState {
  final String? message;

  DetailImamError(this.message);
}
