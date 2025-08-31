// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../feature/app/problems/data/data_sources/problems_data_source.dart'
    as _i296;
import '../../feature/app/problems/data/problem_category/cubit/problem_category_cubit.dart'
    as _i396;
import '../../feature/app/problems/data/problem_category/data/problem_category_data_source.dart'
    as _i808;
import '../../feature/app/problems/data/problem_category/data/problem_category_repository.dart'
    as _i56;
import '../../feature/app/problems/data/repositories/problems_repo_impl.dart'
    as _i472;
import '../../feature/app/problems/domain/repositories/problems_repo.dart'
    as _i84;
import '../../feature/app/problems/domain/use_cases/add_problem_use_case.dart'
    as _i558;
import '../../feature/app/problems/domain/use_cases/address_use_case.dart'
    as _i991;
import '../../feature/app/problems/domain/use_cases/cities_use_case.dart'
    as _i495;
import '../../feature/app/problems/domain/use_cases/create_address_use_case.dart'
    as _i401;
import '../../feature/app/problems/domain/use_cases/problem_by_id.dart'
    as _i943;
import '../../feature/app/problems/domain/use_cases/problems_use_case.dart'
    as _i496;
import '../../feature/app/problems/domain/use_cases/user_use_case.dart'
    as _i504;
import '../../feature/app/problems/presentation/cubit/problems_cubit.dart'
    as _i578;
import '../../feature/app/view_prblem/data/data_source/address_data_source.dart'
    as _i32;
import '../../feature/app/view_prblem/data/data_source/category_data_source.dart'
    as _i132;
import '../../feature/app/view_prblem/data/data_source/photo_data_source.dart'
    as _i542;
import '../../feature/app/view_prblem/data/data_source/problem_byId.dart'
    as _i387;
import '../../feature/app/view_prblem/data/repo/address_repo.dart' as _i161;
import '../../feature/app/view_prblem/data/repo/category_repo.dart' as _i984;
import '../../feature/app/view_prblem/data/repo/photo_repo.dart' as _i321;
import '../../feature/app/view_prblem/data/repo/problem_by_id_repo.dart'
    as _i63;
import '../../feature/app/view_prblem/presentation/cubit/address/address_cubit.dart'
    as _i417;
import '../../feature/app/view_prblem/presentation/cubit/category/category_cubit.dart'
    as _i534;
import '../../feature/app/view_prblem/presentation/cubit/photo/photo_cubit.dart'
    as _i538;
import '../../feature/app/view_prblem/presentation/cubit/view_problem_cubit.dart'
    as _i49;
import '../api_manager/api_di.dart' as _i285;
import '../api_manager/api_manager.dart' as _i266;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioInjection = _$DioInjection();
    gh.singleton<_i361.LogInterceptor>(() => dioInjection.provideLogger());
    gh.singleton<_i808.ProblemCategoryDataSource>(
      () => _i808.ProblemCategoryDataSource(),
    );
    gh.singleton<_i361.Dio>(
      () => dioInjection.provideDIO(gh<_i361.LogInterceptor>()),
    );
    gh.factory<_i56.ProblemCategoryRepository>(
      () =>
          _i56.ProblemCategoryRepository(gh<_i808.ProblemCategoryDataSource>()),
    );
    gh.singleton<_i266.RestClient>(
      () => dioInjection.provideWebServices(gh<_i361.Dio>()),
    );
    gh.singleton<_i32.AddressDataSource>(
      () => _i32.AddressDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i132.CategoryDataSource>(
      () => _i132.CategoryDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i387.ProblemByIDDataSource>(
      () => _i387.ProblemByIDDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i542.PhotoDataSource>(
      () => _i542.PhotoDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i984.CategoryRepo>(
      () => _i984.CategoryRepo(gh<_i132.CategoryDataSource>()),
    );
    gh.factory<_i63.ProblemByIdRepo>(
      () => _i63.ProblemByIdRepo(gh<_i387.ProblemByIDDataSource>()),
    );
    gh.factory<_i396.ProblemCategoryCubit>(
      () => _i396.ProblemCategoryCubit(gh<_i56.ProblemCategoryRepository>()),
    );
    gh.factory<_i321.PhotoRepo>(
      () => _i321.PhotoRepo(gh<_i542.PhotoDataSource>()),
    );
    gh.factory<_i49.ViewProblemCubit>(
      () => _i49.ViewProblemCubit(gh<_i63.ProblemByIdRepo>()),
    );
    gh.factory<_i296.ProblemsDataSource>(
      () => _i296.ProblemsDataSourceImpl(gh<_i266.RestClient>()),
    );
    gh.factory<_i538.PhotoCubit>(() => _i538.PhotoCubit(gh<_i321.PhotoRepo>()));
    gh.factory<_i161.AddressRepo>(
      () => _i161.AddressRepo(gh<_i32.AddressDataSource>()),
    );
    gh.factory<_i84.ProblemsRepo>(
      () => _i472.ProblemsRepoImpl(gh<_i296.ProblemsDataSource>()),
    );
    gh.factory<_i534.CategoryCubit>(
      () => _i534.CategoryCubit(gh<_i984.CategoryRepo>()),
    );
    gh.factory<_i417.AddressCubit>(
      () => _i417.AddressCubit(gh<_i161.AddressRepo>()),
    );
    gh.factory<_i991.AddressUseCase>(
      () => _i991.AddressUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i558.AddProblemUseCase>(
      () => _i558.AddProblemUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i495.CitiesUseCase>(
      () => _i495.CitiesUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i401.CreateAddressUseCase>(
      () => _i401.CreateAddressUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i496.ProblemsUseCase>(
      () => _i496.ProblemsUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i943.ProblemByIdUseCase>(
      () => _i943.ProblemByIdUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i504.UserUseCase>(
      () => _i504.UserUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i578.ProblemsCubit>(
      () => _i578.ProblemsCubit(
        problemsUseCase: gh<_i496.ProblemsUseCase>(),
        userUseCase: gh<_i504.UserUseCase>(),
        addressUseCase: gh<_i991.AddressUseCase>(),
        addProblemUseCase: gh<_i558.AddProblemUseCase>(),
        createAddressUseCase: gh<_i401.CreateAddressUseCase>(),
        citiesUseCase: gh<_i495.CitiesUseCase>(),
        problemByIdUseCase: gh<_i943.ProblemByIdUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioInjection extends _i285.DioInjection {}
