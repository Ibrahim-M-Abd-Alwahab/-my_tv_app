import '../../api_urls.dart';
import '../../base_dio_api.dart';

class AddUserApi extends BaseDioApi {
  final String baseUrl;
  final String username;
  final String password;
  AddUserApi({
    required this.baseUrl,
    required this.username,
    required this.password,
  }) : super(ApiUrls.auth(baseUrl, username, password));

//! we can add the body here
  @override
  body() {
    // return {"baseUrl": baseUrl, "username": username, "password": password};
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
