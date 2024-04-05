import "package:blog_app/core/resources/failure.dart";
import "package:blog_app/core/resources/usecase.dart";
import "package:blog_app/core/shared/entities/profile.dart";
import "package:blog_app/features/auth/domain/repo/auth_repo.dart";
import "package:fpdart/fpdart.dart";

class GetCurrentUser implements UseCase<Profile, NoParams> {
  final AuthRepo _authRepo;
  const GetCurrentUser({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  Future<Either<Failure, Profile>> call({required NoParams params}) async =>
      _authRepo.getCurrentUser();
}
