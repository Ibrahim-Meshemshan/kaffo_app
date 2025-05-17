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

import '../api_manager/api_di.dart' as _i285;
import '../api_manager/api_manager.dart' as _i266;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioInjection = _$DioInjection();
    final appModule = _$AppModule();
    gh.singleton<_i361.Dio>(() => dioInjection.injectDio());
    gh.factory<String>(() => appModule.resetCode, instanceName: 'resetCode');
    gh.singleton<_i266.RestClient>(
      () => dioInjection.injectRestClient(gh<_i361.Dio>()),
    );
    return this;
  }
}

class _$DioInjection extends _i285.DioInjection {}

class _$AppModule extends _i913.AppModule {}
