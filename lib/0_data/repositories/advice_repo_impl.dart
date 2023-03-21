import 'package:dartz/dartz.dart';
import 'package:flutter_pattern/0_data/datasources/advice_remote_datasource.dart';
import 'package:flutter_pattern/0_data/exeptions/exeprions.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';
import 'package:flutter_pattern/1_domain/repositories/advice_repo.dart';

class AdviceRepoImpl extends AdviceRepo {
  AdviceRepoImpl({required this.adviceRemoteDatasource});
  final AdviceRemoteDatasource adviceRemoteDatasource;

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
