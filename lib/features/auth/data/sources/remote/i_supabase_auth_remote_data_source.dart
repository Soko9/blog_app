import "../../../../../core/resources/exceptions.dart";
import "../../models/profile_model.dart";
import "auth_remote_data_source.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class ISupabaseAuthRemoteDataSources implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;
  const ISupabaseAuthRemoteDataSources({
    required SupabaseClient client,
  }) : _supabaseClient = client;

  @override
  Session? get currentUserSession => _supabaseClient.auth.currentSession;

  @override
  Future<ProfileModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final profile = await _supabaseClient.from("profiles").select().eq(
              "id",
              currentUserSession!.user.id,
            );
        return ProfileModel.fromJson(profile.first);
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileModel> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final AuthResponse response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      );
      if (response.user == null) {
        throw const ServerException(message: "User is NULL");
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileModel> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response =
          await _supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException(message: "User is NULL");
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
