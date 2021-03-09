class OtherUserDetails {
  int followersCount;

  OtherUserDetails({
    this.followersCount,
    this.mediaCount,
    this.likes,
    this.comments,
  });

  int mediaCount;
  List<double> likes;
  List<double> comments;

  double get totalLikes => likes.reduce((value, element) => value + element);

  double get totalComments => likes.reduce((value, element) => value + element);

  double get avgComments => totalComments / comments.length;

  double get avgLikes => totalLikes / likes.length;
}
