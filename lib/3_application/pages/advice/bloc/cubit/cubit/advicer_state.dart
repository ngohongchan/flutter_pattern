part of 'advicer_cubit.dart';

abstract class AdvicerCubitState extends Equatable {
  const AdvicerCubitState();

  @override
  List<Object?> get props => [];
}

class AdviceInitial extends AdvicerCubitState {
  const AdviceInitial();
}

class AdvicerStateLoading extends AdvicerCubitState {
  const AdvicerStateLoading();
}

class AdvicerStateLoaded extends AdvicerCubitState {
  final String advice;
  AdvicerStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdvicerStateError extends AdvicerCubitState {
  final String message;
  const AdvicerStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
