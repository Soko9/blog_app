import "dart:io";

import "package:blog_app/core/resources/failure.dart";
import "package:blog_app/core/utils/enums.dart";
import "package:blog_app/features/blog/domain/entities/blog.dart";
import "package:fpdart/fpdart.dart";

abstract interface class BlogRepo {
  void signOutUser();

  Future<Either<Failure, Blog>> publishBlog({
    required File? image,
    required String title,
    required String content,
    required List<TAG> tags,
    required String profileId,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
