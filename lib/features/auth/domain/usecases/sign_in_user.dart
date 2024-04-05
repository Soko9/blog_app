import "../../../../core/resources/failure.dart";
import "../../../../core/resources/usecase.dart";
import "../../../../core/shared/entities/profile.dart";
import "../repo/auth_repo.dart";
import "package:fpdart/fpdart.dart";

class SignInUser implements UseCase<Profile, SignInUserParams> {
  final AuthRepo _authRepo;
  const SignInUser({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  Future<Either<Failure, Profile>> call({
    required SignInUserParams params,
  }) async =>
      await _authRepo.signInUser(
        email: params.email,
        password: params.password,
      );
}
