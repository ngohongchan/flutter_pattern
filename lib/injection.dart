import 'package:flutter_pattern/0_data/datasources/advice_remote_datasource.dart';
import 'package:flutter_pattern/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_pattern/1_domain/repositories/advice_repo.dart';
import 'package:flutter_pattern/1_domain/usecases/advice_usecases.dart';
import 'package:flutter_pattern/3_application/pages/advice/bloc/cubit/cubit/advicer_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; //sl == Service Lacator

Future<void> init() async {
// ! applicaton Layer
  sl.registerFactory(() => AdvicerCubit(adviceUseCases: sl()));

// ! domain Layer
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

// ! data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDatasource>(
      () => AdviceRemoteDataSourceImpl(client: sl()));

// ! externs
  sl.registerFactory(() => http.Client());
}
