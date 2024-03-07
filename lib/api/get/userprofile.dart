// To parse this JSON data, do
//
//     final UserProfileData = UserProfileDataFromJson(jsonString);

import 'dart:convert';

UserProfileData UserProfileDataFromJson(String str) =>
    UserProfileData.fromJson(json.decode(str));

String UserProfileDataToJson(UserProfileData data) =>
    json.encode(data.toJson());

class UserProfileData {
  int status;
  User user;
  String userImageUrl;
  String message;

  UserProfileData({
    required this.status,
    required this.user,
    required this.userImageUrl,
    required this.message,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      UserProfileData(
        status: json["status"],
        user: User.fromJson(json["user"]),
        userImageUrl: json["user_image_url"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
        "user_image_url": userImageUrl,
        "message": message,
      };
}

class User {
  int id;
  String userName;
  String emailId;
  String mobileNumber;
  String dateOfBirth;
  String dateOfAniversary;
  String gender;
  String userImage;

  User({
    required this.id,
    required this.userName,
    required this.emailId,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.dateOfAniversary,
    required this.gender,
    required this.userImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        userName: json["user_name"] ?? "",
        emailId: json["email_id"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        dateOfBirth: json["date_of_birth"] ?? "",
        dateOfAniversary: json["date_of_aniversary"] ?? "null",
        gender: json["gender"] ?? "",
        userImage: json["user_image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email_id": emailId,
        "mobile_number": mobileNumber,
        "date_of_birth": dateOfBirth,
        "date_of_aniversary": dateOfAniversary,
        "gender": gender,
        "user_image": userImage,
      };
}
