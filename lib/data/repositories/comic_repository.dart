import 'package:effective_process_module1/data/models/api_response.dart';
import 'package:effective_process_module1/data/models/comic_model.dart';
import 'package:effective_process_module1/data/services/marvel_service.dart';

class ComicRepository {
  final MarvelService _service;

  ComicRepository(this._service);

  Future<ApiResponse<ComicModel>> getComics({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
  }) async {
    try {
      return await _service.getComics(
        limit: limit,
        offset: offset,
        searchQuery: searchQuery,
      );
    } catch (_) {
      // В случае ошибки возвращаем мок-данные
      return ApiResponse<ComicModel>(
        code: 200,
        status: 'Ok',
        results: _service.getMockComics(),
      );
    }
  }

  Future<List<ComicModel>> getAllComics() async {
    final response = await getComics(limit: 100);
    return response.results;
  }
}