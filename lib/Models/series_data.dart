class AllSeries {
  int? num;
  String? name;
  int? seriesId;
  String? cover;
  String? plot;
  String? cast;
  String? director;
  String? genre;
  String? releaseDate;
  String? lastModified;
  String? rating;
  int? rating5based;
  List<String>? backdropPath;
  String? youtubeTrailer;
  String? episodeRunTime;
  String? categoryId;

  AllSeries(
      {this.num,
      this.name,
      this.seriesId,
      this.cover,
      this.plot,
      this.cast,
      this.director,
      this.genre,
      this.releaseDate,
      this.lastModified,
      this.rating,
      this.rating5based,
      this.backdropPath,
      this.youtubeTrailer,
      this.episodeRunTime,
      this.categoryId});

  AllSeries.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
    seriesId = json['series_id'];
    cover = json['cover'];
    plot = json['plot'];
    cast = json['cast'];
    director = json['director'];
    genre = json['genre'];
    releaseDate = json['releaseDate'];
    lastModified = json['last_modified'];
    rating = json['rating'];
    rating5based = json['rating_5based'];
    backdropPath = json['backdrop_path'].cast<String>();
    youtubeTrailer = json['youtube_trailer'];
    episodeRunTime = json['episode_run_time'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    data['series_id'] = this.seriesId;
    data['cover'] = this.cover;
    data['plot'] = this.plot;
    data['cast'] = this.cast;
    data['director'] = this.director;
    data['genre'] = this.genre;
    data['releaseDate'] = this.releaseDate;
    data['last_modified'] = this.lastModified;
    data['rating'] = this.rating;
    data['rating_5based'] = this.rating5based;
    data['backdrop_path'] = this.backdropPath;
    data['youtube_trailer'] = this.youtubeTrailer;
    data['episode_run_time'] = this.episodeRunTime;
    data['category_id'] = this.categoryId;
    return data;
  }
}
