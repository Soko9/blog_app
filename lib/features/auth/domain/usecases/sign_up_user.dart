import "../../../../core/resources/failure.dart";
import "../../../../core/resources/usecase.dart";
import "../../../../core/shared/entities/profile.dart";
import "../repo/auth_repo.dart";
import "package:fpdart/fpdart.dart";

class SignUpUser implements UseCase<Profile, SignUpUserParams> {
  final AuthRepo _authRepo;
  const SignUpUser({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  Future<Either<Failure, Profile>> call({
    required SignUpUserParams params,
  }) async =>
      await _authRepo.signUpUser(
        email: params.email,
        password: params.password,
        name: params.name,
      );
}
