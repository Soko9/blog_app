import "dart:io";

import "package:blog_app/core/resources/exceptions.dart";
import "package:blog_app/features/blog/data/models/blog_model.dart";
import "package:blog_app/features/blog/data/sources/remote/blog_remote_data_source.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class ISupabaseBlogRemoteDataSource implements BlogRemoteDataSource {
  final SupabaseClient _supabaseClient;
  const ISupabaseBlogRemoteDataSource({required SupabaseClient client})
      : _supabaseClient = client;

  @override
  void signOutUser() {
    _supabaseClient.auth.signOut();
  }

  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final result =
          await _supabaseClient.from("blogs").insert(blog.toJson()).select();
      return BlogModel.fromJson(result.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  }) async {
    try {
      await _supabaseClient.storage.from("blog_images").upload(blogId, image);
      return _supabaseClient.storage.from("blog_images").getPublicUrl(blogId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final result =
          await _supabaseClient.from("blogs").select("*, profiles(name)");
      return result
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              profileName: blog["profiles"]["name"],
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
