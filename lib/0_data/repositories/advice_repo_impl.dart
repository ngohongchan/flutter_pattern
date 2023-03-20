import 'package:dartz/dartz.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';
import 'package:flutter_pattern/1_domain/repositories/advice_repo.dart';

class AdviceRepoImpl extends AdviceRepo {
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() {}
}
