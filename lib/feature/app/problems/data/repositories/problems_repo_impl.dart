import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/feature/app/problems/data/data_sources/problems_data_source.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/repositories/problems_repo.dart';

import '../../../../../core/exceptions/exceptions_impl.dart';


@Injectable(as: ProblemsRepo)
class ProblemsRepoImpl implements ProblemsRepo {
  ProblemsDataSource dataSource;
  ProblemsRepoImpl({required this.dataSource});
  @override
  Future<Result<List<ProblemsContentEntity>>> fetchProblems() async{
    try {
      return await dataSource.fetchProblems();
    } on DioException catch (ex) {
      return Error(ClientError(errorModel: ex.response?.data));
    }
  }

}

