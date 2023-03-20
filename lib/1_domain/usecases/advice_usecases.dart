import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';

class AdviceUseCases {
  Future<AdviceEntity> getAdvice() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    return const AdviceEntity(advice: 'advice to test', id: 1);
  }
}
