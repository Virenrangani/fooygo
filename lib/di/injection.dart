import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../feature/auth/data/data_source/login_data_source.dart';
import '../feature/auth/data/data_source/sign_up_data_source.dart';
import '../feature/auth/data/repository/login_repository_impl.dart';
import '../feature/auth/data/repository/sign_up_repository_impl.dart';
import '../feature/auth/domain/repository/login_repository.dart';
import '../feature/auth/domain/repository/sign_up_repository.dart';
import '../feature/auth/domain/usecase/login_use_case.dart';
import '../feature/auth/domain/usecase/sign_up_use_case.dart';
import '../feature/auth/presentation/cubit/login_cubit.dart';
import '../feature/auth/presentation/cubit/signup_cubit.dart';

class Injection {

  final GetIt sl = GetIt.instance;

   void configDependencies() {
    sl.registerLazySingleton(() => FirebaseAuth.instance);

    sl.registerLazySingleton<LoginDataSource>(()=> LoginDataSourceImpl(sl()));

    sl.registerLazySingleton<LoginRepository>(()=> LoginRepositoryImpl(sl()));

    sl.registerLazySingleton<LoginUseCase>(()=> LoginUseCase(sl()));

    sl.registerFactory(()=>LoginCubit(sl()));

    sl.registerLazySingleton<SignUpDataSource>(()=>SignUpDataSourceImpl(sl()));

    sl.registerLazySingleton<SignUpRepository>(()=> SignUpRepositoryImpl(sl()));

    sl.registerLazySingleton<SignUpUseCase>(()=> SignUpUseCase(sl()));

    sl.registerFactory(()=>SignupCubit(sl()));


  }
}