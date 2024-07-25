var TOKEN = '';
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};
String getYoutubeVideoId(String url) {
  Uri uri = Uri.parse(url);

  // Check if the URL is a standard YouTube URL
  if (uri.host.contains('youtube.com')) {
    return uri.queryParameters['v'] ?? '';
  }

  // Check if the URL is a shortened YouTube URL
  if (uri.host.contains('youtu.be')) {
    return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';
  }

  return '';
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

