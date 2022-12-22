import 'package:equatable/equatable.dart';

class PhotosModel extends Equatable {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const PhotosModel(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  Map<String, dynamic> toMap() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory PhotosModel.fromMap(Map<String, dynamic> map) {
    return PhotosModel(
      albumId: map['albumId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
    );
  }

  @override
  List<Object> get props {
    return [
      albumId,
      id,
      title,
      url,
      thumbnailUrl,
    ];
  }
}
