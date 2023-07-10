class ChannelData {
  List<Resources>? resources;
  Pagination? pagination;

  ChannelData({this.resources, this.pagination});

  ChannelData.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources!.add(new Resources.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resources != null) {
      data['resources'] = this.resources!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Resources {
  int? id;
  String? name;
  String? urlLink;
  Null? catgeroy;
  String? createdDate;
  int? sourceId;

  Resources(
      {this.id,
      this.name,
      this.urlLink,
      this.catgeroy,
      this.createdDate,
      this.sourceId});

  Resources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    urlLink = json['urlLink'];
    catgeroy = json['catgeroy'];
    createdDate = json['createdDate'];
    sourceId = json['sourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['urlLink'] = this.urlLink;
    data['catgeroy'] = this.catgeroy;
    data['createdDate'] = this.createdDate;
    data['sourceId'] = this.sourceId;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalRecords;
  int? pageSize;

  Pagination({this.currentPage, this.totalRecords, this.pageSize});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalRecords = json['totalRecords'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalRecords'] = this.totalRecords;
    data['pageSize'] = this.pageSize;
    return data;
  }
}
