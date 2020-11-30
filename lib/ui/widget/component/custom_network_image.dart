import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final int imageColor;
  final int progressColor;
  final double width;
  final double height;

  const CustomNetworkImage(this.url, this.imageColor, this.progressColor, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(url),
      color: Color(imageColor),
      width: width,
      height: height,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(
              progressColor
            ),
          ),);
      },
    );

  }
}
