import "package:blog_app/core/resources/usecase.dart";

import "../repo/blog_repo.dart";

class SignOutUser implements UseCaseVoid<void, NoParams> {
  final BlogRepo _blogRepo;
  const SignOutUser({required BlogRepo repo}) : _blogRepo = repo;

  @override
  void call({required NoParams params}) => _blogRepo.signOutUser();
}
