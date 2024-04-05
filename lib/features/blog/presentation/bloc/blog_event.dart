part of "blog_bloc.dart";

@immutable
sealed class BlogEvent {
  const BlogEvent();
}

final class BlogSignOutUserEvent extends BlogEvent {
  const BlogSignOutUserEvent();
}

final class BlogPublishEvent extends BlogEvent {
  final String title;
  final String content;
  final List<TAG> tags;
  final File? image;
  final String profileId;

  const BlogPublishEvent({
    required this.title,
    required this.content,
    required this.tags,
    required this.image,
    required this.profileId,
  });
}

final class BlogGetAllBlogsEvent extends BlogEvent {
  const BlogGetAllBlogsEvent();
}
