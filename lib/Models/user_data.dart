class UserData {
  UserInfo? userInfo;
  ServerInfo? serverInfo;

  UserData({this.userInfo, this.serverInfo});

  UserData.fromJson(Map<String, dynamic> map) {
    userInfo =
        map['user_info'] != null ? UserInfo.fromJson(map['user_info']) : null;
    serverInfo = map['server_info'] != null
        ? ServerInfo.fromJson(map['server_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    if (serverInfo != null) {
      data['server_info'] = serverInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? username;
  String? password;
  String? message;
  int? auth;
  String? status;
  String? expDate;
  String? isTrial;
  String? activeCons;
  String? createdAt;
  String? maxConnections;
  List<dynamic>? allowedOutputFormats;

  UserInfo({
    this.username,
    this.password,
    this.message,
    this.auth,
    this.status,
    this.expDate,
    this.isTrial,
    this.activeCons,
    this.createdAt,
    this.maxConnections,
    this.allowedOutputFormats,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    message = json['message'];
    auth = json['auth'];
    status = json['status'];
    expDate = json['exp_date'];
    isTrial = json['is_trial'];
    activeCons = json['active_cons'];
    createdAt = json['created_at'];
    maxConnections = json['max_connections'];
    allowedOutputFormats = json['allowed_output_formats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['message'] = message;
    data['auth'] = auth;
    data['status'] = status;
    data['exp_date'] = expDate;
    data['is_trial'] = isTrial;
    data['active_cons'] = activeCons;
    data['created_at'] = createdAt;
    data['max_connections'] = maxConnections;
    data['allowed_output_formats'] = allowedOutputFormats;
    return data;
  }
}

class ServerInfo {
  String? url;
  String? port;
  String? httpsPort;
  String? serverProtocol;
  String? rtmpPort;
  String? timezone;
  int? timestampNow;
  String? timeNow;

  ServerInfo({
    this.url,
    this.port,
    this.httpsPort,
    this.serverProtocol,
    this.rtmpPort,
    this.timezone,
    this.timestampNow,
    this.timeNow,
  });

  ServerInfo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    port = json['port'];
    httpsPort = json['https_port'];
    serverProtocol = json['server_protocol'];
    rtmpPort = json['rtmp_port'];
    timezone = json['timezone'];
    timestampNow = json['timestamp_now'];
    timeNow = json['time_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['port'] = port;
    data['https_port'] = httpsPort;
    data['server_protocol'] = serverProtocol;
    data['rtmp_port'] = rtmpPort;
    data['timezone'] = timezone;
    data['timestamp_now'] = timestampNow;
    data['time_now'] = timeNow;
    return data;
  }
}
