class AllMovie {
  dynamic? num;
  dynamic? name;
  dynamic? streamType;
  dynamic? streamId;
  dynamic? streamIcon;
  dynamic? rating;
  dynamic? rating5based;
  dynamic? added;
  dynamic? categoryId;
  dynamic? containerExtension;
  dynamic customSid;
  dynamic? directSource;
  dynamic? seriesId;

  AllMovie(
      {this.num,
      this.name,
      this.seriesId,
      this.streamType,
      this.streamId,
      this.streamIcon,
      this.rating,
      this.rating5based,
      this.added,
      this.categoryId,
      this.containerExtension,
      this.customSid,
      this.directSource});

  AllMovie.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
    seriesId = json['series_id'];
    streamType = json['stream_type'];
    streamId = json['stream_id'];
    streamIcon = json['stream_icon'];
    rating = json['rating'];
    rating5based = json['rating_5based'];
    added = json['added'];
    categoryId = json['category_id'];
    containerExtension = json['container_extension'];
    customSid = json['custom_sid'];
    directSource = json['direct_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['name'] = name;
    data['stream_type'] = streamType;
    data['stream_id'] = streamId;
    data['stream_icon'] = streamIcon;
    data['rating'] = rating;
    data['rating_5based'] = rating5based;
    data['added'] = added;
    data['category_id'] = categoryId;
    data['container_extension'] = containerExtension;
    data['custom_sid'] = customSid;
    data['direct_source'] = directSource;
    return data;
  }
}
