import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;
  final String detailUrl;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.detailUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      thumbnailUrl:
          '${json['thumbnail']?['path']}.${json['thumbnail']?['extension']}',
      detailUrl: json['urls']?[0]?['url'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];
}