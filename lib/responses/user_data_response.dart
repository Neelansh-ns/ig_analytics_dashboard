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
    this.insights,
  });

  Account account;
  Insights insights;

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) => GetUserDataResponse(
        account: json["account"] == null ? null : Account.fromJson(json["account"]),
        insights: json["insights"] == null ? null : Insights.fromJson(json["insights"]),
      );

  Map<String, dynamic> toJson() => {
        "account": account == null ? null : account.toJson(),
        "insights": insights == null ? null : insights.toJson(),
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
          instgramBusinessAccountId: this.account.body.id,
          pageName: this.account.body.name,
          insights: UserInsights(
            impressions: this
                .insights
                .body
                .data
                .firstWhere((element) => element.name == 'impressions')
                .values
                .map((e) => e.value.toDouble())
                .toList(),
            profileViews: this
                .insights
                .body
                .data
                .firstWhere((element) => element.name == 'profile_views')
                .values
                .map((e) => e.value.toDouble())
                .toList(),
            reach: this
                .insights
                .body
                .data
                .firstWhere((element) => element.name == 'reach')
                .values
                .map((e) => e.value.toDouble())
                .toList(),
          ));
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
  AccountBody body;
  String url;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        body: json["body"] == null ? null : AccountBody.fromJson(json["body"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode == null ? null : statusCode,
        "body": body == null ? null : body.toJson(),
        "url": url == null ? null : url,
      };
}

class AccountBody {
  AccountBody({
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

  factory AccountBody.fromJson(Map<String, dynamic> json) => AccountBody(
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

class Insights {
  Insights({
    this.statusCode,
    this.body,
    this.url,
  });

  int statusCode;
  InsightsBody body;
  String url;

  factory Insights.fromJson(Map<String, dynamic> json) => Insights(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        body: json["body"] == null ? null : InsightsBody.fromJson(json["body"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode == null ? null : statusCode,
        "body": body == null ? null : body.toJson(),
        "url": url == null ? null : url,
      };
}

class InsightsBody {
  InsightsBody({
    this.data,
    this.paging,
  });

  List<Datum> data;
  Paging paging;

  factory InsightsBody.fromJson(Map<String, dynamic> json) => InsightsBody(
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
    this.name,
    this.period,
    this.values,
    this.title,
    this.description,
    this.id,
  });

  String name;
  String period;
  List<Value> values;
  String title;
  String description;
  String id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : json["name"],
        period: json["period"] == null ? null : json["period"],
        values: json["values"] == null
            ? null
            : List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "period": period == null ? null : period,
        "values": values == null ? null : List<dynamic>.from(values.map((x) => x.toJson())),
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "id": id == null ? null : id,
      };
}

class Value {
  Value({
    this.value,
    this.endTime,
  });

  int value;
  String endTime;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        value: json["value"] == null ? null : json["value"],
        endTime: json["end_time"] == null ? null : json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "end_time": endTime == null ? null : endTime,
      };
}

class Paging {
  Paging({
    this.previous,
    this.next,
  });

  String previous;
  String next;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        previous: json["previous"] == null ? null : json["previous"],
        next: json["next"] == null ? null : json["next"],
      );

  Map<String, dynamic> toJson() => {
        "previous": previous == null ? null : previous,
        "next": next == null ? null : next,
      };
}
