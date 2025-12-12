import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:effective_process_module1/data/models/comic_model.dart';
import 'package:effective_process_module1/data/repositories/comic_repository.dart';


class ProjectsViewModel with ChangeNotifier {
  final ComicRepository _repository;
  
  ProjectsViewModel(this._repository) {
    _loadProjects();
  }
  
  List<ComicModel> _projects = [];
  List<ComicModel> get projects => _projects;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  
  Future<void> _loadProjects() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final response = await _repository.getComics(
        limit: 20,
        searchQuery: _searchQuery.isNotEmpty ? _searchQuery : null,
      );
      
      _projects = response.results;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Ошибка загрузки проектов: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> refresh() async {
    await _loadProjects();
  }
  
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _debouncedSearch();
  }
  
  Timer? _debounceTimer;
  void _debouncedSearch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _loadProjects();
    });
  }
  
  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}