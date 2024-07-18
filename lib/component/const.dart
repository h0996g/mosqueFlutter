var TOKEN = '';
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};
String getYoutubeVideoId(String url) {
  Uri uri = Uri.parse(url);
  return uri.queryParameters['v'] ?? '';
}
// String getYoutubeVideoId(String url) {
//   String videoId = '';
//   if (url.contains('youtube.com')) {
//     videoId = url.split('v=')[1];
//     if (videoId.contains('&')) {
//       videoId = videoId.split('&')[0];
//     }
//   } else if (url.contains('youtu.be')) {
//     videoId = url.split('.be/')[1];
//   }
//   return videoId;
// }

