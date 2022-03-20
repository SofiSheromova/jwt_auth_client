abstract class ExhibitionsRepository {
  Future<Map<String, dynamic>> getExhibitions({int offset, int limit});
}
