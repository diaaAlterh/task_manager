import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/views/widgets/shimmer_placeholder.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;
  final double? radius;

  const ImageView({Key? key, required this.imageUrl, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return imageProviderForWeb();
    } else {
      return imageProviderForMobile(context);
    }
  }

  Widget imageProviderForWeb() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return CustomShimmer.squarer();
        },
      ),
    );
  }

  Widget imageProviderForMobile(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => CustomShimmer.squarer(),
        errorWidget: (context, url, error) => errorPlaceholder(context),
      ),
    );
  }

  Widget errorPlaceholder(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(Icons.movie_creation,color: Theme.of(context).colorScheme.primary,size: 75,));
  }
}
