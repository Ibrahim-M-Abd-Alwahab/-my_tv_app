import '../../api_urls.dart';
import '../../base_dio_api.dart';

class GetMovieDataApi extends BaseDioApi {
  final String baseUrl;
  final String username;
  final String password;
  final String action;

  GetMovieDataApi(
      {required this.baseUrl,
      required this.username,
      required this.password,
      required this.action})
      : super(ApiUrls.authWithAction(baseUrl, username, password, action));

  @override
  body() {
    return {};
  }

  Future fetch() async {
    //* u can  chose the what the request type
    //! Get , Post , Put , Delete
    final response = await getRequest();
    return response;
  }
}
