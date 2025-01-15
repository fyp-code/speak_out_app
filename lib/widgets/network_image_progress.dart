import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWithProgress extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;

  const NetworkImageWithProgress({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: height,
      width: width,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
    // return Image.network(
    //   imageUrl,
    //   loadingBuilder: (BuildContext context, Widget child,
    //       ImageChunkEvent? loadingProgress) {
    //     if (loadingProgress == null) {
    //       return child;
    //     } else {
    //       double progress = loadingProgress.expectedTotalBytes != null
    //           ? loadingProgress.cumulativeBytesLoaded /
    //               (loadingProgress.expectedTotalBytes ?? 1)
    //           : 0;
    //       return Stack(
    //         children: [
    //           Center(
    //             child: CircularProgressIndicator(
    //               value: progress,
    //               strokeWidth: 2,
    //             ),
    //           ),
    //           Center(
    //             child: Text(
    //               '${(progress * 100).toStringAsFixed(0)}%',
    //               style: const TextStyle(fontSize: 12),
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //   },
    //   errorBuilder: (context, error, stackTrace) {
    //     return const Icon(Icons.error);
    //   },
    // );
  }
}
