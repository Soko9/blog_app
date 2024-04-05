import "../../../../core/shared/entities/profile.dart";
import "package:fpdart/fpdart.dart";

import "../../../../core/resources/failure.dart";

abstract interface class AuthRepo {
  Future<Either<Failure, Profile>> getCurrentUser();

  Future<Either<Failure, Profile>> signUpUser({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, Profile>> signInUser({
    required String email,
    required String password,
  });
}
