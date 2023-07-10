import '../api_urls.dart';
import '../base_dio_api.dart';

class GetDataAPi extends BaseDioApi {
  final String? page;

  GetDataAPi({this.page}) : super(ApiUrls.data(page));

  @override
  body() {
    return {};
  }

  Future fetch() async {
    final response = await getRequest();
    return response;
  }
}
