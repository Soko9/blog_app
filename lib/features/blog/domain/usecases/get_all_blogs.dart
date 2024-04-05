import "package:blog_app/core/resources/failure.dart";
import "package:blog_app/core/resources/usecase.dart";
import "package:blog_app/features/blog/domain/entities/blog.dart";
import "package:fpdart/fpdart.dart";

import "../repo/blog_repo.dart";

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepo _repo;
  const GetAllBlogs({required BlogRepo repo}) : _repo = repo;

  @override
  Future<Either<Failure, List<Blog>>> call({required NoParams params}) async =>
      await _repo.getAllBlogs();
}
