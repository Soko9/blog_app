import "package:blog_app/core/utils/enums.dart";

class Blog {
  final String id;
  final String profileId;
  final String title;
  final String content;
  final List<TAG> tags;
  final String? imageUrl;
  final DateTime createdAt;
  final String? profileName;

  Blog({
    required this.id,
    required this.profileId,
    required this.title,
    required this.content,
    required this.tags,
    required this.imageUrl,
    required this.createdAt,
    this.profileName,
  });
}
