import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_auth_client/data/converters/generic_converter.dart';

part 'collection_response.g.dart';

@JsonSerializable(createToJson: false)
class CollectionResponse<T> extends Equatable {
  final int? count;
  @GenericConverter()
  final List<T> items;

  const CollectionResponse({
    this.count,
    required this.items,
  });

  factory CollectionResponse.fromJson(Map<String, dynamic> json) => _$CollectionResponseFromJson(json);

  @override
  List<Object?> get props => [count, ...items];

  @override
  bool? get stringify => true;
}
