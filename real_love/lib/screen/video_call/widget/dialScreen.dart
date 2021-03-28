
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_love/utils/sizeConfig.dart';
import 'package:real_love/widget/loading.dart';

class DialUserPic extends StatelessWidget {
  const DialUserPic({
    Key key,
    this.size = 192,
    @required this.image, this.url,
  }) : super(key: key);

  final double size;
  final String image;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30 / 192 * size),
      height: getProportionateScreenWidth(size),
      width: getProportionateScreenWidth(size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.02),
            Colors.white.withOpacity(0.05)
          ],
          stops: [.5, 1],
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child:
        url == null ? Positioned(child: Loading(),)
            : CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        ), /*Image.asset(
          image,
          fit: BoxFit.cover,
        ),*/
      ),
    );
  }
}