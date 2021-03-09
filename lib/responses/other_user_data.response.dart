// To parse this JSON data, do
//
//     final getOtherUserDataResponse = getOtherUserDataResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ig_analytics_dashboard/models/other_user_details.dart';

GetOtherUserDataResponse getOtherUserDataResponseFromJson(String str) =>
    GetOtherUserDataResponse.fromJson(json.decode(str));

String getOtherUserDataResponseToJson(GetOtherUserDataResponse data) => json.encode(data.toJson());

class GetOtherUserDataResponse {
  GetOtherUserDataResponse({
    this.userdetails,
  });

  Userdetails userdetails;

  factory GetOtherUserDataResponse.fromJson(Map<String, dynamic> json) => GetOtherUserDataResponse(
        userdetails: json["userdetails"] == null ? null : Userdetails.fromJson(json["userdetails"]),
      );

  Map<String, dynamic> toJson() => {
        "userdetails": userdetails == null ? null : userdetails.toJson(),
      };

  OtherUserDetails mapToOtherUserDetails() {
    if (this?.userdetails?.body != null) {
      return OtherUserDetails(
          followersCount: this.userdetails.body.businessDiscovery?.followersCount,
          mediaCount: this.userdetails.body.businessDiscovery?.mediaCount,
          comments: this
              .userdetails
              .body
              .businessDiscovery
              .media
              .data
              .map((e) => e.commentsCount.toDouble())
              .toList(),
          likes: this
              .userdetails
              .body
              .businessDiscovery
              .media
              .data
              .map((e) => e.likeCount.toDouble())
              .toList());
    }
    return null;
  }
}

class Userdetails {
  Userdetails({
    this.statusCode,
    this.body,
    this.url,
  });

  int statusCode;
  Body body;
  String url;

  factory Userdetails.fromJson(Map<String, dynamic> json) => Userdetails(
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
    this.businessDiscovery,
    this.id,
  });

  BusinessDiscovery businessDiscovery;
  String id;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        businessDiscovery: json["business_discovery"] == null
            ? null
            : BusinessDiscovery.fromJson(json["business_discovery"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "business_discovery": businessDiscovery == null ? null : businessDiscovery.toJson(),
        "id": id == null ? null : id,
      };
}

class BusinessDiscovery {
  BusinessDiscovery({
    this.followersCount,
    this.mediaCount,
    this.media,
    this.id,
  });

  int followersCount;
  int mediaCount;
  Media media;
  String id;

  factory BusinessDiscovery.fromJson(Map<String, dynamic> json) => BusinessDiscovery(
        followersCount: json["followers_count"] == null ? null : json["followers_count"],
        mediaCount: json["media_count"] == null ? null : json["media_count"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "followers_count": followersCount == null ? null : followersCount,
        "media_count": mediaCount == null ? null : mediaCount,
        "media": media == null ? null : media.toJson(),
        "id": id == null ? null : id,
      };
}

class Media {
  Media({
    this.data,
    this.paging,
  });

  List<Datum> data;
  Paging paging;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging == null ? null : paging.toJson(),
      };
}

class Datum {
  Datum({
    this.commentsCount,
    this.likeCount,
    this.id,
  });

  int commentsCount;
  int likeCount;
  String id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        commentsCount: json["comments_count"] == null ? null : json["comments_count"],
        likeCount: json["like_count"] == null ? null : json["like_count"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "comments_count": commentsCount == null ? null : commentsCount,
        "like_count": likeCount == null ? null : likeCount,
        "id": id == null ? null : id,
      };
}

class Paging {
  Paging({
    this.cursors,
  });

  Cursors cursors;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        cursors: json["cursors"] == null ? null : Cursors.fromJson(json["cursors"]),
      );

  Map<String, dynamic> toJson() => {
        "cursors": cursors == null ? null : cursors.toJson(),
      };
}

class Cursors {
  Cursors({
    this.after,
  });

  String after;

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
        after: json["after"] == null ? null : json["after"],
      );

  Map<String, dynamic> toJson() => {
        "after": after == null ? null : after,
      };
}
