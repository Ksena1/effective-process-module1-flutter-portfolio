import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:effective_process_module1/data/models/api_response.dart';
import 'package:effective_process_module1/data/models/character_model.dart';
import 'package:effective_process_module1/data/models/comic_model.dart';

class MarvelService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://gateway.marvel.com/v1/public/'));
  final String _publicKey = 'YOUR_PUBLIC_KEY'; // Нужно получить на developer.marvel.com
  final String _privateKey = 'YOUR_PRIVATE_KEY';

  String _generateHash(String timestamp) {
    final bytes = utf8.encode(timestamp + _privateKey + _publicKey);
    return md5.convert(bytes).toString();
  }

  Future<ApiResponse<CharacterModel>> getCharacters({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _generateHash(timestamp);

    final params = {
      'apikey': _publicKey,
      'ts': timestamp,
      'hash': hash,
      'limit': limit,
      'offset': offset,
      'orderBy': 'name',
      if (searchQuery != null && searchQuery.isNotEmpty) 'nameStartsWith': searchQuery,
    };

    try {
      final response = await _dio.get('characters', queryParameters: params);
      return ApiResponse<CharacterModel>.fromJson(
        response.data,
        (json) => CharacterModel.fromJson(json),
      );
    } catch (e) {
      throw Exception('Failed to load characters: $e');
    }
  }

  Future<ApiResponse<ComicModel>> getComics({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _generateHash(timestamp);

    final params = {
      'apikey': _publicKey,
      'ts': timestamp,
      'hash': hash,
      'limit': limit,
      'offset': offset,
      'orderBy': 'title',
      if (searchQuery != null && searchQuery.isNotEmpty) 'titleStartsWith': searchQuery,
    };

    try {
      final response = await _dio.get('comics', queryParameters: params);
      return ApiResponse<ComicModel>.fromJson(
        response.data,
        (json) => ComicModel.fromJson(json),
      );
    } catch (e) {
      throw Exception('Failed to load comics: $e');
    }
  }

  // Для демо, если нет ключей API
  List<CharacterModel> getMockCharacters() {
    return List.generate(10, (index) => CharacterModel(
      id: index + 1,
      name: 'Character ${index + 1}',
      description: 'Description for character ${index + 1}',
      thumbnailUrl: 'https://via.placeholder.com/150',
      detailUrl: '',
    ));
  }

  List<ComicModel> getMockComics() {
    return List.generate(10, (index) => ComicModel(
      id: index + 1,
      title: 'Project ${index + 1}',
      description: 'Description for project ${index + 1}',
      thumbnailUrl: 'https://via.placeholder.com/150',
      detailUrl: '',
      pageCount: Random().nextInt(100),
    ));
  }
}