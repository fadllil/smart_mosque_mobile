part of 'detail_masjid_cubit.dart';

abstract class DetailMasjidState extends Equatable {
  const DetailMasjidState();
  @override
  List<Object> get props => [];
}

class DetailMasjidInitial extends DetailMasjidState {}
class DetailMasjidLoading extends DetailMasjidState {}
class DetailMasjidLoaded extends DetailMasjidState {}
class DetailMasjidFailure extends DetailMasjidState {
  final String? message;

  DetailMasjidFailure(this.message);
}

class DetailMasjidCreating extends DetailMasjidState {}
class DetailMasjidCreated extends DetailMasjidState {}
class DetailMasjidError extends DetailMasjidState {
  final String? message;

  DetailMasjidError(this.message);
}