import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodygo/feature/forget_password/data/data_source/forget_pass_data_source.dart';
import 'package:foodygo/feature/forget_password/data/repository_impl/forget_pass_repository_impl.dart';
import 'package:foodygo/feature/forget_password/domain/repository/forget_pass_repository.dart';
import 'package:foodygo/feature/forget_password/domain/use_case/forget_pass_use_case.dart';
import 'package:foodygo/feature/forget_password/presentation/cubit/forget_pass_cubit.dart';
import 'package:foodygo/feature/home/data/data_source/home_data_source.dart';
import 'package:foodygo/feature/home/data/repository_impl/home_repository_impl.dart';
import 'package:foodygo/feature/home/domain/repository/home_repository.dart';
import 'package:foodygo/feature/home/domain/use_case/food_use_case.dart';
import 'package:foodygo/feature/home/presentation/cubit/home_cubit.dart';
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
    sl.registerLazySingleton(()=>FirebaseFirestore.instance);

    sl.registerLazySingleton<LoginDataSource>(()=> LoginDataSourceImpl(sl()));
    sl.registerLazySingleton<LoginRepository>(()=> LoginRepositoryImpl(sl()));
    sl.registerLazySingleton<LoginUseCase>(()=> LoginUseCase(sl()));
    sl.registerFactory(()=>LoginCubit(sl()));

    sl.registerLazySingleton<SignUpDataSource>(()=>SignUpDataSourceImpl(sl()));
    sl.registerLazySingleton<SignUpRepository>(()=> SignUpRepositoryImpl(sl()));
    sl.registerLazySingleton<SignUpUseCase>(()=> SignUpUseCase(sl()));
    sl.registerFactory(()=>SignupCubit(sl()));

    sl.registerLazySingleton<ForgetPassDataSource>(()=>ForgetPassDataSourceImpl(sl()));
    sl.registerLazySingleton<ForgetPassRepository>(()=>ForgetPassRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>ForgetPassUseCase(sl()));
    sl.registerFactory(()=>ForgetPassCubit(sl()));

    sl.registerLazySingleton<HomeDataSource>(()=>HomeDataSourceImpl(sl()));
    sl.registerLazySingleton<HomeRepository>(()=>HomeRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>GetFoodUseCase(sl()));
    sl.registerFactory(()=>HomeCubit(getFoodUseCase: sl()));
  }
}