class ApiUrls {
  static const String baseUrl =
      'http://mohmohzobeidah22-001-site1.btempurl.com/api';

  // auth
  static String data(page) => '$baseUrl/Resource?Pagenumber=$page';

  // xtream
  static String auth(baseUrl, userName, password) =>
      '$baseUrl/player_api.php?username=$userName&password=$password';
  static String authWithAction(baseUrl, userName, password, action) =>
      '$baseUrl/player_api.php?username=$userName&password=$password&action=$action';

//         String x='asd=12&&fff=33&&eee=6&&ghjkl';
//  List<String> splits= x.split('&&');

//     for (var i = 0; i < splits.length; i++ ){
//  List<String> splits2= splits[i].split('=');
//                               print( splits2 );

// }
}
