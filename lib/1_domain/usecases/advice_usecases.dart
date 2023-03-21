import 'package:dartz/dartz.dart';
import 'package:flutter_pattern/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';
import 'package:flutter_pattern/1_domain/repositories/advice_repo.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    // await Future.delayed(const Duration(seconds: 3), () {});
    // //call to repo went good -> return data not failure
    // return right(const AdviceEntity(advice: 'advice to test', id: 1));
    // //call to repo went bad or logic had an error -> return failure
    // // return left(CacheFailure());
    return adviceRepo.getAdviceFromDataSource();
  }
}
