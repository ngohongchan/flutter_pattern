import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';
import 'package:flutter_pattern/1_domain/usecases/advice_usecases.dart';

part 'advicer_state.dart';

const generalFailureMessage = 'Ups. something gone wrong, Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, cache failed. Please try again!';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdviceInitial());
  final AdviceUseCases adviceUseCases = AdviceUseCases();
  // could also use other use cases

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    final failureOrActive = await adviceUseCases.getAdvice();
    failureOrActive.fold(
      (failure) => emit(
        AdvicerStateError(
          message: _mapFailureToMessage(failure),
        ),
      ),
      (advice) => emit(
        AdvicerStateLoaded(advice: advice.advice),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
