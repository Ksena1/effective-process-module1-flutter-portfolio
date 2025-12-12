import 'package:equatable/equatable.dart';

class ComicModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String detailUrl;
  final int pageCount;

  const ComicModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.detailUrl,
    required this.pageCount,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      thumbnailUrl:
          '${json['thumbnail']?['path']}.${json['thumbnail']?['extension']}',
      detailUrl: json['urls']?[0]?['url'] ?? '',
      pageCount: json['pageCount'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, title];
}