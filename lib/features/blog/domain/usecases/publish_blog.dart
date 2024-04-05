import "package:blog_app/core/resources/failure.dart";
import "package:blog_app/core/resources/usecase.dart";
import "package:blog_app/features/blog/domain/entities/blog.dart";
import "package:blog_app/features/blog/domain/repo/blog_repo.dart";
import "package:fpdart/fpdart.dart";

class PublishBlog implements UseCase<Blog, PublishBlogParams> {
  final BlogRepo _blogRepo;
  const PublishBlog({required BlogRepo repo}) : _blogRepo = repo;

  @override
  Future<Either<Failure, Blog>> call({
    required PublishBlogParams params,
  }) async =>
      await _blogRepo.publishBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        tags: params.tags,
        profileId: params.profileId,
      );
}
