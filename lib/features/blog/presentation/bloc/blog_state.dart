part of "blog_bloc.dart";

@immutable
sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {
  const BlogInitial();
}

final class BlogLoading extends BlogState {
  const BlogLoading();
}

final class BlogFailure extends BlogState {
  final String message;
  const BlogFailure({required this.message});
}

final class BlogPublishSuccess extends BlogState {
  // final Blog blog;
  // const BlogPublishSuccess({required this.blog});
  const BlogPublishSuccess();
}

final class BlogFetchSuccess extends BlogState {
  final List<Blog> blogs;
  const BlogFetchSuccess({required this.blogs});
}
