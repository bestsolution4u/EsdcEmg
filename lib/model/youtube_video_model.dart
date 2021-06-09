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

  YoutubeVideoModel.fromFirebase(Map<String, dynamic> json) {
    this.id = json['id'];
    this.publishedAt = json['publishedAt'];
    this.title = json['title'];
    this.description = json['description'];
    this.thumbnail = json['thumbnail'];
    this.duration = json['duration'];
    this.viewCount = json['viewCount'];
    this.likeCount = json['likeCount'];
    this.dislikeCount = json['dislikeCount'];
    this.favoriteCount = json['favoriteCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['publishedAt'] = this.publishedAt;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['duration'] = this.duration;
    data['viewCount'] = this.viewCount;
    data['likeCount'] = this.likeCount;
    data['dislikeCount'] = this.dislikeCount;
    data['favoriteCount'] = this.favoriteCount;
    return data;
  }
}