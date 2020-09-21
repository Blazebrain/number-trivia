import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivial/core/network/network_info.dart';
import 'package:number_trivial/core/utils/input_converter.dart';
import 'package:number_trivial/features/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivial/features/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivial/features/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivial/features/domain/repositories/number_trivial_repository.dart';
import 'package:number_trivial/features/domain/usecases/get_concrete_number_trivial.dart';
import 'package:number_trivial/features/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivial/features/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  //! Features -Number Trivia
  // BLoc registration
  sl.registerFactory(() => NumberTriviaBloc(
        concrete: sl(),
        random: sl(),
        inputConverter: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            localDatasource: sl(),
            remoteDatasource: sl(),
            networkInfo: sl(),
          ));
  // Datasources
  sl.registerLazySingleton<NumberTriviaLocalDatasource>(
      () => NumberTriviaLocalDatasourceImpl(sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDatasource>(
      () => NumberTriviaRemoteDatasourceImpl(client: sl()));
  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ! Core
  sl.registerLazySingleton(() => InputConverter());

  // ! External / 3rd Party Api's
  final sharedPreferences = await SharedPreferences.getInstance();
  // whenever a function is made asynchronous, it returns a future of whatever it is meant to return
  // its better to store it in a seperate variable and then call it in the function
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
