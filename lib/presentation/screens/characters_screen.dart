import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_process_module1/presentation/viewmodels/characters_viewmodel.dart';
import 'package:effective_process_module1/presentation/providers/app_provider.dart';
import 'package:effective_process_module1/data/models/character_model.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late CharactersViewModel _viewModel;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    _viewModel = CharactersViewModel(appProvider.characterRepository);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<CharactersViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Команда компании'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Поиск сотрудников...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                viewModel.updateSearchQuery('');
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      viewModel.updateSearchQuery(value);
                    },
                  ),
                ),
              ),
            ),
            body: _buildBody(viewModel),
            floatingActionButton: FloatingActionButton(
              onPressed: () => viewModel.refresh(),
              child: const Icon(Icons.refresh),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(CharactersViewModel viewModel) {
    if (viewModel.isLoading && viewModel.characters.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              viewModel.errorMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.refresh(),
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    if (viewModel.characters.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Сотрудники не найдены'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.refresh(),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: viewModel.characters.length,
        separatorBuilder: (context, index) => const Divider(height: 8),
        itemBuilder: (context, index) {
          return _buildCharacterTile(viewModel.characters[index]);
        },
      ),
    );
  }

  Widget _buildCharacterTile(CharacterModel character) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[300],
        backgroundImage: CachedNetworkImageProvider(character.thumbnailUrl),
        child: character.thumbnailUrl.isEmpty
            ? const Icon(Icons.person, size: 30)
            : null,
      ),
      title: Text(
        character.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        character.description.isNotEmpty
            ? character.description
            : 'Нет описания',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Навигация на детальный экран
      },
    );
  }
}