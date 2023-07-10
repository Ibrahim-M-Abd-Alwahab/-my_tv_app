// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Users {
  String? username;
  String? password;
  String? userUrl;
  String? ip;
  int? flag;

  Users({
    this.username,
    this.password,
    this.userUrl,
    this.flag,
    this.ip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'userUrl': userUrl,
      'flag': flag,
      'ip': ip,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      username: map['username'],
      password: map['password'],
      userUrl: map['userUrl'],
      flag: map['flag'],
      ip: map['ip'],
    );
  }
  @override
  String toString() {
    return '($username, password: $password, flag: $flag, ip: $ip , userUrl: $userUrl)';
  }
}
