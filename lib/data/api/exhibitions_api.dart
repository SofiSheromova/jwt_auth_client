import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'exhibitions_api.g.dart';

@RestApi()
abstract class ExhibitionsApi {
  factory ExhibitionsApi(Dio dio) = _ExhibitionsApi;

  @GET('/exhibitions')
  Future<dynamic> getExhibitions({
    @Query('offset') required int offset,
    @Query('limit') required int limit,
  });
}
