part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}
class DetailLoading extends DetailState {}
class DetailLoaded extends DetailState {}
class DetailFailure extends DetailState {
  final String? message;

  DetailFailure(this.message);
}

class DetailUpdating extends DetailState {}
class DetailUpdated extends DetailState {}
class DetailError extends DetailState {
  final String? message;

  DetailError(this.message);
}