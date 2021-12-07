part of 'jamaah_cubit.dart';

abstract class JamaahState extends Equatable {
  const JamaahState();

  @override
  List<Object> get props => [];
}

class JamaahInitial extends JamaahState {}
class JamaahLoading extends JamaahState {}
class JamaahLoaded extends JamaahState {}
class JamaahFailure extends JamaahState {
  final String? message;

  JamaahFailure(this.message);
}

class JamaahError extends JamaahState {
  final String? message;

  JamaahError(this.message);
}
