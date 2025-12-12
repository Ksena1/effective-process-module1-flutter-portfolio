import 'package:effective_process_module1/data/models/api_response.dart';
import 'package:effective_process_module1/data/models/character_model.dart';
import 'package:effective_process_module1/data/services/marvel_service.dart';

class CharacterRepository {
  final MarvelService _service;

  CharacterRepository(this._service);

  Future<ApiResponse<CharacterModel>> getCharacters({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
  }) async {
    try {
      return await _service.getCharacters(
        limit: limit,
        offset: offset,
        searchQuery: searchQuery,
      );
    } catch (_) {
      // В случае ошибки возвращаем мок-данные
      return ApiResponse<CharacterModel>(
        code: 200,
        status: 'Ok',
        results: _service.getMockCharacters(),
      );
    }
  }

  Future<List<CharacterModel>> getAllCharacters() async {
    final response = await getCharacters(limit: 100);
    return response.results;
  }
}