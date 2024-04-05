import "dart:io";

import "package:blog_app/features/blog/data/models/blog_model.dart";

abstract interface class BlogRemoteDataSource {
  void signOutUser();

  Future<BlogModel> uploadBlog({required BlogModel blog});

  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  });

  Future<List<BlogModel>> getAllBlogs();
}
