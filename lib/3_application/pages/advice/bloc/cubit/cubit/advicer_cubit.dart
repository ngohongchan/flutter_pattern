import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/usecases/advice_usecases.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdviceInitial());
  final AdviceUseCases adviceUseCases = AdviceUseCases();
  // could also use other usecases

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    final AdviceEntity advice = await adviceUseCases.getAdvice();
    // execute business logic
    // for example get and advice
    debugPrint('fake get advice triggered');
    // await Future.delayed(const Duration(seconds: 3), () {});
    debugPrint('got advice');
    emit(AdvicerStateLoaded(advice: advice.advice));
    // emit(AdvicerStateError(message: 'error message'));
  }
}
