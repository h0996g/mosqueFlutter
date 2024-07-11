var TOKEN = '';
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};
String getYoutubeVideoId(String url) {
  Uri uri = Uri.parse(url);
  return uri.queryParameters['v'] ?? '';
}
