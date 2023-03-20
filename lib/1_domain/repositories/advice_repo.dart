import 'package:dartz/dartz.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
