import "dart:io";

import "package:blog_app/core/utils/enums.dart";
import "package:fpdart/fpdart.dart";

import "failure.dart";

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

abstract interface class UseCaseVoid<Type, Params> {
  Type call({required Params params});
}

class NoParams {}

// auth params
class SignUpUserParams {
  final String email;
  final String password;
  final String name;

  const SignUpUserParams({
    required this.email,
    required this.password,
    required this.name,
  });
}

class SignInUserParams {
  final String email;
  final String password;

  const SignInUserParams({
    required this.email,
    required this.password,
  });
}

// blog params
class PublishBlogParams {
  final String title;
  final String content;
  final List<TAG> tags;
  final File? image;
  final String profileId;

  PublishBlogParams({
    required this.title,
    required this.content,
    required this.tags,
    required this.image,
    required this.profileId,
  });
}
