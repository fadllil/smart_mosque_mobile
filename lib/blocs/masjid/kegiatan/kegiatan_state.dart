part of 'kegiatan_cubit.dart';

abstract class KegiatanState extends Equatable {
  const KegiatanState();
  @override
  List<Object> get props => [];
}

class KegiatanInitial extends KegiatanState {}
class KegiatanLoading extends KegiatanState {}
class KegiatanLoaded extends KegiatanState {}
class KegiatanFailure extends KegiatanState {
  final String message;

  KegiatanFailure(this.message);
}

class KegiatanCreating extends KegiatanState {}
class KegiatanCreated extends KegiatanState {}
class KegiatanUpdating extends KegiatanState {}
class KegiatanUpdated extends KegiatanState {}
class KegiatanUpdatingStatus extends KegiatanState {}
class KegiatanUpdatedStatus extends KegiatanState {}
class KegiatanDeleting extends KegiatanState {}
class KegiatanDeleted extends KegiatanState {}
class KegiatanError extends KegiatanState {
  final String message;

  KegiatanError(this.message);
}
