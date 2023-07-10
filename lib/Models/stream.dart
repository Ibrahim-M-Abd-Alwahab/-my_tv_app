class StreamingModel {
  int? num;
  String? name;
  String? streamType;
  int? streamId;
  String? streamIcon;
  dynamic epgChannelId;
  String? added;
  String? categoryId;
  String? customSid;
  int? tvArchive;
  String? directSource;
  int? tvArchiveDuration;

  StreamingModel(
      {this.num,
      this.name,
      this.streamType,
      this.streamId,
      this.streamIcon,
      this.epgChannelId,
      this.added,
      this.categoryId,
      this.customSid,
      this.tvArchive,
      this.directSource,
      this.tvArchiveDuration});

  StreamingModel.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
    streamType = json['stream_type'];
    streamId = json['stream_id'];
    streamIcon = json['stream_icon'];
    epgChannelId = json['epg_channel_id'];
    added = json['added'];
    categoryId = json['category_id'];
    customSid = json['custom_sid'];
    tvArchive = json['tv_archive'];
    directSource = json['direct_source'];
    tvArchiveDuration = json['tv_archive_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['name'] = name;
    data['stream_type'] = streamType;
    data['stream_id'] = streamId;
    data['stream_icon'] = streamIcon;
    data['epg_channel_id'] = epgChannelId;
    data['added'] = added;
    data['category_id'] = categoryId;
    data['custom_sid'] = customSid;
    data['tv_archive'] = tvArchive;
    data['direct_source'] = directSource;
    data['tv_archive_duration'] = tvArchiveDuration;
    return data;
  }
}
