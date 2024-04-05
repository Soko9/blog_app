import "../../../../core/shared/entities/profile.dart";

class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json,
          [bool isSignIn = false]) =>
      ProfileModel(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        name:
            isSignIn ? json["user_metadata"]["name"] ?? "" : json["name"] ?? "",
      );
}
