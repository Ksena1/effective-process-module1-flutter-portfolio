# Effective Process - Модуль 1: Мобильное приложение-портфолио

Мобильное приложение для системы Effective.process (ООО "Красавчик"), разработанное в рамках учебной практики.

## 📱 О проекте

Приложение-портфолио компании, отображающее проекты и команды сотрудников. Разработано на Flutter с использованием архитектуры MVVM.

### Основные функции
- Просмотр списка проектов компании (GridView.builder)
- Просмотр списка сотрудников (ListView.separated)
- Поиск с debounce-оптимизацией
- Поддержка темной/светлой темы
- Работа с Marvel Comics API (демо-данные)

## 🏗️ Архитектура

Проект использует трехслойную архитектуру:

### 1. Data Layer
- **Models**: `CharacterModel`, `ComicModel`, `ApiResponse`
- **Services**: `MarvelService` (работа с API через Dio)
- **Repositories**: `CharacterRepository`, `ComicRepository`

### 2. Domain Layer
- **Entities**: Бизнес-сущности
- **UseCases**: Бизнес-логика
- **Repositories**: Абстракции для доступа к данным

### 3. Presentation Layer
- **ViewModels**: `ProjectsViewModel`, `CharactersViewModel`
- **Screens**: `ProjectsScreen`, `CharactersScreen`, `HomeScreen`
- **Widgets**: Переиспользуемые компоненты
- **Providers**: `AppProvider` (управление состоянием)

## 🛠️ Технологии

- **Flutter 3.38.4** (Dart 3.10.3)
- **State Management**: Provider
- **HTTP Client**: Dio
- **Image Caching**: cached_network_image
- **Architecture**: MVVM
- **API**: Marvel Comics API (для демо-данных)

## 📦 Установка и запуск

### Предварительные требования
1. Установите [Flutter SDK](https://flutter.dev/docs/get-started/install)
2. Установите [Git](https://git-scm.com/)

### Клонирование репозитория
```bash
git clone https://github.com/ваш-юзернейм/effective-process-module1-flutter-portfolio.git
cd effective-process-module1-flutter-portfolio