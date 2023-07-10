class SerisInfoModel {
  SerInfo? info;
  List<Seasons>? seasons;

  Map<String, List<Episode>>? episodes;

  SerisInfoModel({this.info, this.episodes, this.seasons});

  factory SerisInfoModel.fromJson(Map<String, dynamic> json) {
    var info = SerInfo.fromJson(json['info']);
    var episodesMap = json['episodes'];
    var episodes = <String, List<Episode>>{};
    episodesMap.forEach((key, value) {
      episodes[key] = (value as List).map((e) => Episode.fromJson(e)).toList();
    });
    var seas = <Seasons>[];

    if (json['seasons'] != null) {
      json['seasons'].forEach((v) {
        seas.add(Seasons.fromJson(v));
      });
    }

    return SerisInfoModel(info: info, episodes: episodes, seasons: seas);
  }
}

class SerInfo {
  String? name;
  String? cover;
  String? plot;
  String? cast;
  String? director;
  String? genre;
  String? releaseDate;
  String? lastModified;
  String? rating;
  dynamic rating5based;
  List<String>? backdropPath;
  String? youtubeTrailer;
  String? episodeRunTime;
  String? categoryId;

  SerInfo(
      {this.name,
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

  SerInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cover'] = cover;
    data['plot'] = plot;
    data['cast'] = cast;
    data['director'] = director;
    data['genre'] = genre;
    data['releaseDate'] = releaseDate;
    data['last_modified'] = lastModified;
    data['rating'] = rating;
    data['rating_5based'] = rating5based;
    data['backdrop_path'] = backdropPath;
    data['youtube_trailer'] = youtubeTrailer;
    data['episode_run_time'] = episodeRunTime;
    data['category_id'] = categoryId;
    return data;
  }
}

class Episode {
  dynamic? id;
  dynamic? episodeNum;
  dynamic? title;
  dynamic? containerExtension;
  Info? info;

  Episode(
      {this.id,
      this.episodeNum,
      this.title,
      this.containerExtension,
      this.info});

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    episodeNum = json['episode_num'];
    title = json['title'];
    containerExtension = json['container_extension'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['episode_num'] = episodeNum;
    data['title'] = title;
    data['container_extension'] = containerExtension;
    if (info != null) {
      data['info'] = info?.toJson();
    }
    return data;
  }
}

class Info {
  dynamic? durationSecs;
  dynamic? duration;

  Info({
    this.durationSecs,
    this.duration,
  });

  Info.fromJson(Map<String, dynamic> json) {
    durationSecs = json['duration_secs'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration_secs'] = durationSecs;
    data['duration'] = duration;

    return data;
  }
}

class Seasons {
  String? airDate;
  dynamic episodeCount;
  dynamic id;
  String? name;
  String? overview;
  dynamic seasonNumber;
  String? cover;
  String? coverBig;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.seasonNumber,
      this.cover,
      this.coverBig});

  Seasons.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeCount = json['episode_count'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    seasonNumber = json['season_number'];
    cover = json['cover'];
    coverBig = json['cover_big'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_count'] = episodeCount;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['season_number'] = seasonNumber;
    data['cover'] = cover;
    data['cover_big'] = coverBig;
    return data;
  }
}
