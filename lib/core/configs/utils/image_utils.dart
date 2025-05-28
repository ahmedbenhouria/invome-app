import 'package:flutter_svg/flutter_svg.dart';

import '../assets/app_vectors.dart';

class ImageUtils {
  static void svgPrecacheImage() {
    const cacheSvgImages = [
      /// Specify the all the svg image to cache
    ];

    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache.putIfAbsent(
        loader.cacheKey(null),
        () => loader.loadBytes(null),
      );
    }
  }
}
