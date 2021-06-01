class YoutubeVideoModel {
  String id, publishedAt, title, description, thumbnail, duration, viewCount, likeCount, dislikeCount, favoriteCount;

  YoutubeVideoModel({
    this.id,
    this.publishedAt,
    this.title,
    this.description,
    this.thumbnail,
    this.duration,
    this.viewCount,
    this.likeCount,
    this.dislikeCount,
    this.favoriteCount});

  YoutubeVideoModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    Map<String, dynamic> snippet = json['snippet'];
    this.publishedAt = snippet['publishedAt'];
    this.title = snippet['title'];
    this.description = snippet['description'];
    this.thumbnail = snippet['thumbnails']['high']['url'];
    this.duration = json['contentDetails']['duration'];
    Map<String, dynamic> statistics = json['statistics'];
    this.viewCount = statistics['viewCount'];
    this.likeCount = statistics['likeCount'];
    this.dislikeCount = statistics['dislikeCount'];
    this.favoriteCount = statistics['favoriteCount'];
  }
}