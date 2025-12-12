import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:effective_process_module1/data/models/character_model.dart';
import 'package:effective_process_module1/data/repositories/character_repository.dart';

class CharactersViewModel with ChangeNotifier {
  final CharacterRepository _repository;
  
  CharactersViewModel(this._repository) {
    _loadCharacters();
  }
  
  List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  
  Future<void> _loadCharacters() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final response = await _repository.getCharacters(
        limit: 20,
        searchQuery: _searchQuery.isNotEmpty ? _searchQuery : null,
      );
      
      _characters = response.results;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Ошибка загрузки сотрудников: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> refresh() async {
    await _loadCharacters();
  }
  
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _debouncedSearch();
  }
  
  Timer? _debounceTimer;
  void _debouncedSearch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _loadCharacters();
    });
  }
  
  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}