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
import '../../feature/app/problems/data/repositories/problems_repo_impl.dart'
    as _i472;
import '../../feature/app/problems/domain/repositories/problems_repo.dart'
    as _i84;
import '../../feature/app/problems/domain/use_cases/problems_use_case.dart'
    as _i496;
import '../../feature/app/problems/domain/use_cases/user_use_case.dart'
    as _i504;
import '../../feature/app/problems/presentation/cubit/problems_cubit.dart'
    as _i578;
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
    gh.singleton<_i361.Dio>(
      () => dioInjection.provideDIO(gh<_i361.LogInterceptor>()),
    );
    gh.singleton<_i266.RestClient>(
      () => dioInjection.provideWebServices(gh<_i361.Dio>()),
    );
    gh.factory<_i296.ProblemsDataSource>(
      () => _i296.ProblemsDataSourceImpl(gh<_i266.RestClient>()),
    );
    gh.factory<_i84.ProblemsRepo>(
      () => _i472.ProblemsRepoImpl(dataSource: gh<_i296.ProblemsDataSource>()),
    );
    gh.factory<_i496.ProblemsUseCase>(
      () => _i496.ProblemsUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i504.UserUseCase>(
      () => _i504.UserUseCase(gh<_i84.ProblemsRepo>()),
    );
    gh.factory<_i578.ProblemsCubit>(
      () => _i578.ProblemsCubit(
        problemsUseCase: gh<_i496.ProblemsUseCase>(),
        userUseCase: gh<_i504.UserUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioInjection extends _i285.DioInjection {}
