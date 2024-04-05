import "dart:io";

import "package:blog_app/core/resources/exceptions.dart";
import "package:blog_app/core/resources/failure.dart";
import "package:blog_app/core/shared/network/network_connectivity.dart";
import "package:blog_app/core/utils/enums.dart";
import "package:blog_app/features/blog/data/sources/local/blog_local_data_source.dart";
import "package:blog_app/features/blog/data/sources/remote/blog_remote_data_source.dart";
import "package:blog_app/features/blog/domain/repo/blog_repo.dart";
import "package:fpdart/fpdart.dart";
import "package:uuid/uuid.dart";

import "../models/blog_model.dart";

class IBlogRepo implements BlogRepo {
  final BlogRemoteDataSource _blogRemoteDataSource;
  final BlogLocalDataSource _blogLocalDataSource;
  final NetworkConnectivity _networkConnectivity;

  const IBlogRepo({
    required BlogRemoteDataSource remoteDataSource,
    required BlogLocalDataSource localDataSource,
    required NetworkConnectivity connectivity,
  })  : _blogRemoteDataSource = remoteDataSource,
        _blogLocalDataSource = localDataSource,
        _networkConnectivity = connectivity;

  @override
  void signOutUser() {
    _blogRemoteDataSource.signOutUser();
  }

  @override
  Future<Either<Failure, BlogModel>> publishBlog({
    required File? image,
    required String title,
    required String content,
    required List<TAG> tags,
    required String profileId,
  }) async {
    try {
      if (!await (_networkConnectivity.isConnected)) {
        return left(const Failure(message: "No internet connection!"));
      }

      final String id = const Uuid().v4();

      String? imageUrl;
      if (image != null) {
        imageUrl = await _blogRemoteDataSource.uploadBlogImage(
          image: image,
          blogId: id,
        );
      }

      final BlogModel blog = BlogModel(
        id: id,
        profileId: profileId,
        title: title,
        content: content,
        tags: tags,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
      );

      final BlogModel result = await _blogRemoteDataSource.uploadBlog(
        blog: blog,
      );

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogModel>>> getAllBlogs() async {
    try {
      if (!await (_networkConnectivity.isConnected)) {
        final blogs = _blogLocalDataSource.retrieveBlogsFromHive();
        return right(blogs);
      }
      final List<BlogModel> result = await _blogRemoteDataSource.getAllBlogs();
      _blogLocalDataSource.uploadBlogsToHive(blogs: result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
