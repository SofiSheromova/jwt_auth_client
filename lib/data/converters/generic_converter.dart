import 'package:json_annotation/json_annotation.dart';

class GenericConverter<T> implements JsonConverter<T, Object> {
  const GenericConverter();

  @override
  T fromJson(Object json) {
    json = json as Map<String, dynamic>;
    switch (T) {
      // case Exhibition:
      //   return Exhibition.fromJson(json) as T;

      default:
        throw ArgumentError('There is no converter for type $T.');
    }
  }

  @override
  Object toJson(T object) {
    switch (T) {
      default:
        throw ArgumentError('There is no converter for type $T.');
    }
  }
}
