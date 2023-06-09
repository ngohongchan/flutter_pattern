part of 'advice_bloc.dart';

@immutable
abstract class AdviceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviceInitial extends AdviceState {}

class AdvicerStateLoading extends AdviceState {}

class AdvicerStateLoaded extends AdviceState {
  final String advice;
  AdvicerStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdvicerStateError extends AdviceState {
  final String message;
  AdvicerStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
