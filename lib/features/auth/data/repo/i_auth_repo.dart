import "package:blog_app/core/shared/network/network_connectivity.dart";
import "package:supabase_flutter/supabase_flutter.dart";

import "../../../../core/resources/exceptions.dart";
import "../../../../core/resources/failure.dart";
import "../models/profile_model.dart";
import "../sources/remote/auth_remote_data_source.dart";
import "package:fpdart/fpdart.dart";

import "../../domain/repo/auth_repo.dart";

class IAuthRepo implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final NetworkConnectivity _connectivity;

  const IAuthRepo({
    required AuthRemoteDataSource authRemoteDataSource,
    required NetworkConnectivity connectivity,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _connectivity = connectivity;

  @override
  Future<Either<Failure, ProfileModel>> getCurrentUser() async {
    try {
      if (!await _connectivity.isConnected) {
        final session = _authRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(const Failure(message: "User is not logged in"));
        }
        return right(
          ProfileModel(
            id: session.user.id,
            name: session.user.userMetadata!["name"],
            email: session.user.email!,
          ),
        );
      }
      final profile = await _authRemoteDataSource.getCurrentUser();
      if (profile != null) {
        return right(profile);
      }
      return left(const Failure(message: "User is not logged in"));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    return _getResult(
      () async => await _authRemoteDataSource.signUpUser(
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  @override
  Future<Either<Failure, ProfileModel>> signInUser({
    required String email,
    required String password,
  }) async {
    return _getResult(
      () async => await _authRemoteDataSource.signInUser(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, ProfileModel>> _getResult(
    Future<ProfileModel> Function() fn,
  ) async {
    try {
      if (!await _connectivity.isConnected) {
        return left(const Failure(message: "No internet connection!"));
      }
      final ProfileModel profile = await fn();
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } on AuthException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
