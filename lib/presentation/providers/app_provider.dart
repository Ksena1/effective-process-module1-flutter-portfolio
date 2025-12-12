import 'package:flutter/foundation.dart';
import 'package:effective_process_module1/data/services/marvel_service.dart';
import 'package:effective_process_module1/data/repositories/character_repository.dart';
import 'package:effective_process_module1/data/repositories/comic_repository.dart';

class AppProvider with ChangeNotifier {
  late final MarvelService _marvelService;
  late final CharacterRepository _characterRepository;
  late final ComicRepository _comicRepository;
  
  AppProvider() {
    _marvelService = MarvelService();
    _characterRepository = CharacterRepository(_marvelService);
    _comicRepository = ComicRepository(_marvelService);
  }
  
  MarvelService get marvelService => _marvelService;
  CharacterRepository get characterRepository => _characterRepository;
  ComicRepository get comicRepository => _comicRepository;
  
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}