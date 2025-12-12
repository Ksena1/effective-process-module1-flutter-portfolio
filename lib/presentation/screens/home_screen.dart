import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:effective_process_module1/presentation/providers/app_provider.dart';
import 'package:effective_process_module1/presentation/screens/projects_screen.dart';
import 'package:effective_process_module1/presentation/screens/characters_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ProjectsScreen(),
    CharactersScreen(),
    PlaceholderWidget(title: 'Избранное'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Effective Process Portfolio'),
        actions: [
          Consumer<AppProvider>(
            builder: (context, appProvider, child) {
              return IconButton(
                icon: Icon(
                  appProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  appProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'Проекты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Команды',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Избранное',
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Экран "$title" в разработке',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}