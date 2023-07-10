import '../../base_dio_api.dart';

class GetUserDataByAction extends BaseDioApi {
  @override
  // ignore: overridden_fields
  final String url;
  GetUserDataByAction({required this.url}) : super(url);

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
