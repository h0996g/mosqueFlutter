import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends CacheManager {
  static const key = 'customCache';

  static CustomCacheManager instance = CustomCacheManager._();

  CustomCacheManager._()
      : super(
          Config(
            key,
            stalePeriod:
                const Duration(days: 7), // Change to the desired cache duration
            maxNrOfCacheObjects: 100,
            repo: JsonCacheInfoRepository(databaseName: key),
            fileService: HttpFileService(),
          ),
        );
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double borderRadius;

  const CachedNetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.borderRadius = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: CustomCacheManager.instance,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error),
      ),
      fit: fit,
    );
  }
}

class CachedNetworkImageWidgetProvider {
  static ImageProvider getImageProvider(String imageUrl) {
    return CachedNetworkImageProvider(
      imageUrl,
      cacheManager: CustomCacheManager.instance,
    );
  }
}
