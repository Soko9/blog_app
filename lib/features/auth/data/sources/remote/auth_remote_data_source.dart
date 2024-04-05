import "package:supabase_flutter/supabase_flutter.dart";

import "../../models/profile_model.dart";

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<ProfileModel?> getCurrentUser();

  Future<ProfileModel> signUpUser({
    required String email,
    required String password,
    required String name,
  });

  Future<ProfileModel> signInUser({
    required String email,
    required String password,
  });
}
