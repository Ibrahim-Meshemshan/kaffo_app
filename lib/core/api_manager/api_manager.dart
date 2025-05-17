import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_manager.g.dart';

@RestApi(baseUrl: 'https://flower.elevateegy.com/api/v1/drivers/')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

}
