import "package:blog_app/core/resources/exceptions.dart";
import "package:blog_app/features/blog/data/models/blog_model.dart";
import "package:blog_app/features/blog/data/sources/local/blog_local_data_source.dart";
import "package:hive/hive.dart";

class IHiveBlogLocalDataSource implements BlogLocalDataSource {
  final Box _hiveBox;
  const IHiveBlogLocalDataSource({required Box box}) : _hiveBox = box;

  @override
  List<BlogModel> retrieveBlogsFromHive() {
    final List<BlogModel> blogs = List.empty(growable: true);
    try {
      _hiveBox.read(() {
        for (int i = 0; i < blogs.length; i++) {
          blogs.add(BlogModel.fromJson(_hiveBox.get(i.toString())));
        }
      });
    } catch (e) {
      throw LocalException(message: e.toString());
    }
    return blogs;
  }

  @override
  void uploadBlogsToHive({required List<BlogModel> blogs}) {
    _hiveBox.clear();

    try {
      _hiveBox.write(() {
        for (int i = 0; i < blogs.length; i++) {
          _hiveBox.put(i.toString(), blogs[i].toJson());
        }
      });
    } catch (e) {
      throw LocalException(message: e.toString());
    }
  }
}
