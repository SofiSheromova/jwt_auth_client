import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'content_api.g.dart';

@RestApi()
abstract class ContentApi {
  factory ContentApi(Dio dio) = _ContentApi;

  @GET('/main_app/get_content')
  Future<dynamic> getSecretContent();
}
