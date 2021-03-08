// To parse this JSON data, do
//
//     final getUserDataResponse = getUserDataResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ig_analytics_dashboard/models/user_details.dart';

GetUserDataResponse getUserDataResponseFromJson(String str) =>
    GetUserDataResponse.fromJson(json.decode(str));

String getUserDataResponseToJson(GetUserDataResponse data) => json.encode(data.toJson());

class GetUserDataResponse {
  GetUserDataResponse({
    this.account,
  });

  Account account;

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) => GetUserDataResponse(
        account: json["account"] == null ? null : Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "account": account == null ? null : account.toJson(),
      };

  UserDetails mapToUserDetails() {
    if (this?.account != null) {
      return UserDetails(
        totalPosts: this.account.body.mediaCount,
        biography: this.account.body.biography,
        username: this.account.body.username,
        followersCount: this.account.body.followersCount,
        followsCount: this.account.body.followsCount,
        profilePic: this.account.body.profilePictureUrl,
        pageName: this.account.body.name,
      );
    }
    return null;
  }
}

class Account {
  Account({
    this.statusCode,
    this.body,
    this.url,
  });

  int statusCode;
  Body body;
  String url;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode == null ? null : statusCode,
        "body": body == null ? null : body.toJson(),
        "url": url == null ? null : url,
      };
}

class Body {
  Body({
    this.biography,
    this.followersCount,
    this.followsCount,
    this.mediaCount,
    this.name,
    this.username,
    this.profilePictureUrl,
    this.id,
  });

  String biography;
  int followersCount;
  int followsCount;
  int mediaCount;
  String name;
  String username;
  String profilePictureUrl;
  String id;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        biography: json["biography"] == null ? null : json["biography"],
        followersCount: json["followers_count"] == null ? null : json["followers_count"],
        followsCount: json["follows_count"] == null ? null : json["follows_count"],
        mediaCount: json["media_count"] == null ? null : json["media_count"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        profilePictureUrl: json["profile_picture_url"] == null ? null : json["profile_picture_url"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "biography": biography == null ? null : biography,
        "followers_count": followersCount == null ? null : followersCount,
        "follows_count": followsCount == null ? null : followsCount,
        "media_count": mediaCount == null ? null : mediaCount,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
        "profile_picture_url": profilePictureUrl == null ? null : profilePictureUrl,
        "id": id == null ? null : id,
      };
}
