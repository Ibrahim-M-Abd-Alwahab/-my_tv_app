class VideoModel {
  List<Files>? files;
  String? folderName;

  VideoModel({this.files, this.folderName});

  VideoModel.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['folderName'] = folderName;
    return data;
  }
}

class Files {
  String? path;
  String? dateAdded;
  String? displayName;
  String? duration;
  String? size;

  Files(
      {this.path, this.dateAdded, this.displayName, this.duration, this.size});

  Files.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    dateAdded = json['dateAdded'];
    displayName = json['displayName'];
    duration = json['duration'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['dateAdded'] = dateAdded;
    data['displayName'] = displayName;
    data['duration'] = duration;
    data['size'] = size;
    return data;
  }
}
