import "../../models/blog_model.dart";

abstract interface class BlogLocalDataSource {
  void uploadBlogsToHive({required List<BlogModel> blogs});

  List<BlogModel> retrieveBlogsFromHive();
}
