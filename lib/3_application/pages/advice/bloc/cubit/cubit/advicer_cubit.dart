import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdviceInitial());

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    // execute business logic
    // for example get and advice
    debugPrint('fake get advice triggered');
    await Future.delayed(const Duration(seconds: 3), () {});
    debugPrint('got advice');
    emit(AdvicerStateLoaded(advice: 'fake advice test bloc'));
    // emit(AdvicerStateError(message: 'error message'));
  }
}
