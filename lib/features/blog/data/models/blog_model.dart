import "package:blog_app/core/utils/enums.dart";
import "package:blog_app/features/blog/domain/entities/blog.dart";

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.profileId,
    required super.title,
    required super.content,
    required super.tags,
    required super.imageUrl,
    required super.createdAt,
    super.profileName,
  });

  BlogModel copyWith({
    String? id,
    String? profileId,
    String? title,
    String? content,
    List<TAG>? tags,
    String? imageUrl,
    DateTime? createdAt,
    String? profileName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      profileName: profileName ?? this.profileName,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_id": profileId,
        "title": title,
        "content": content,
        "tags": tags.map((e) => e.name).toList(),
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
      };

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map["id"] as String,
      profileId: map["profile_id"] as String,
      title: map["title"] as String,
      content: map["content"] as String,
      tags: (map["tags"] as List<dynamic>)
          .map(
            (value) => TAG.values.firstWhere(
              (e) => e.name == value.toString(),
              orElse: () => TAG.business,
            ),
          )
          .toList(),
      imageUrl: map["image_url"] as String?,
      createdAt: map["created_at"] == null
          ? DateTime.now()
          : DateTime.parse(map["created_at"] as String),
    );
  }
}
