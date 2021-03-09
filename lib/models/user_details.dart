class UserDetails {
  int totalPosts;
  String biography;
  String username;
  String profilePic;
  String pageName;
  int followsCount;
  int followersCount;
  UserInsights insights;

  UserDetails({
    this.totalPosts,
    this.biography,
    this.username,
    this.followsCount,
    this.followersCount,
    this.profilePic,
    this.pageName,
    this.insights,
  });
}

class UserInsights {
  List<double> impressions;
  List<double> profileViews;
  List<double> reach;

  UserInsights({
    this.impressions,
    this.profileViews,
    this.reach,
  });

  double get totalReach => reach.reduce((value, element) => value + element);

  double get totalProfileViews => reach.reduce((value, element) => value + element);

  double get totalImpression => reach.reduce((value, element) => value + element);
}
