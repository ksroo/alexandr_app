import 'package:alexandr_test_app/app/services/api_interceptors.dart';
import 'package:alexandr_test_app/app/services/api_services.dart';
import 'package:alexandr_test_app/app/services/dio_consumer.dart';
import 'package:alexandr_test_app/repository/photos/photos_api.dart';
import 'package:alexandr_test_app/repository/photos/photos_repo.dart';
import 'package:alexandr_test_app/view/photos/logic/photos_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initialAppDependencyInjector() async {
//! APi

  sl.registerLazySingleton<PhotosApi>(() => PhotosApi(sl()));
  //! repository
  sl.registerLazySingleton<PhotosRepo>(() => PhotosRepo(sl()));
  //! bloc
  sl.registerFactory<PhotosBloc>(() => PhotosBloc(sl()));
  //! External
  sl.registerLazySingleton<ApiServices>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton(() => ApiIntercepters());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
  sl.registerLazySingleton(() => Dio());
}
