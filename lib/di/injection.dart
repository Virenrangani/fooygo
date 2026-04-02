import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodygo/feature/admin_login/data/data_source/admin_data_source.dart';
import 'package:foodygo/feature/admin_login/data/repository_impl/admin_repository_impl.dart';
import 'package:foodygo/feature/admin_login/domain/repository/admin_repository.dart';
import 'package:foodygo/feature/admin_login/domain/use_case/admin_use_case.dart';
import 'package:foodygo/feature/admin_login/presentation/cubit/admin_cubit.dart';
import 'package:foodygo/feature/cart/data/data_source/cart_data_source.dart';
import 'package:foodygo/feature/cart/data/repository_impl/cart_repository_impl.dart';
import 'package:foodygo/feature/cart/domain/repository/cart_repository.dart';
import 'package:foodygo/feature/cart/domain/use_case/checkout_use_case.dart';
import 'package:foodygo/feature/cart/domain/use_case/get_cart_use_case.dart';
import 'package:foodygo/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:foodygo/feature/food_page%20/data/data_source/food_details_data_source.dart';
import 'package:foodygo/feature/food_page%20/data/repository_impl/food_details_repository_impl.dart';
import 'package:foodygo/feature/food_page%20/domain/repository/food_details_repository.dart';
import 'package:foodygo/feature/food_page%20/domain/use_case/add_to_cart_use_case.dart';
import 'package:foodygo/feature/food_page%20/presentation/cubit/food_details_cubit.dart';
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
import 'package:foodygo/feature/profile/data/data_source/profile_data_source.dart';
import 'package:foodygo/feature/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:foodygo/feature/profile/domain/repository/profile_repository.dart';
import 'package:foodygo/feature/profile/domain/use_case/profile_use_case.dart';
import 'package:foodygo/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:foodygo/feature/wallet/data/data_source/wallet_data_source.dart';
import 'package:foodygo/feature/wallet/data/repository_impl/wallet_repository_impl.dart';
import 'package:foodygo/feature/wallet/domain/repository/wallet_repository.dart';
import 'package:foodygo/feature/wallet/domain/use_case/get_wallet_use_case.dart';
import 'package:foodygo/feature/wallet/domain/use_case/update_wallet_use_case.dart';
import 'package:foodygo/feature/wallet/presentation/cubit/wallet_cubit.dart';
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
    sl.registerLazySingleton(()=>FirebaseStorage.instance);

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

    sl.registerLazySingleton<WalletDataSource>(()=>WalletDataSourceImpl(sl()));
    sl.registerLazySingleton<WalletRepository>(()=>WalletRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>GetWalletUseCase(sl()));
    sl.registerLazySingleton(()=>UpdateWalletUseCase(sl()));
    sl.registerFactory(()=>WalletCubit(getWalletUseCase: sl(), updateWalletUseCase: sl()));

    sl.registerLazySingleton<DetailsDataSource>(()=>DetailsDataSourceImpl(sl()));
    sl.registerLazySingleton<DetailsRepository>(()=>DetailsRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>AddToCartUseCase(sl()));
    sl.registerFactory(()=>DetailsCubit(addToCartUseCase: sl()));

    sl.registerLazySingleton<CartDataSource>(()=>CartDataSourceImpl(sl()));
    sl.registerLazySingleton<CartRepository>(()=>CartRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>CheckoutUseCase(sl()));
    sl.registerLazySingleton(()=>GetCartUseCase(sl()));
    sl.registerFactory(()=>CartCubit(sl(),sl()));

    sl.registerLazySingleton<ProfileDataSource>(()=>ProfileDataSourceImpl(sl(),sl()));
    sl.registerLazySingleton<ProfileRepository>(()=>ProfileRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>ProfileUseCase(sl()));
    sl.registerFactory(()=>ProfileCubit(sl()));

    sl.registerLazySingleton<AdminDataSource>(()=>AdminDataSourceImpl(sl()));
    sl.registerLazySingleton<AdminRepository>(()=>AdminRepositoryImpl(sl()));
    sl.registerLazySingleton(()=>AdminLoginUseCase(sl()));
    sl.registerFactory(()=>AdminCubit(sl()));
  }
}