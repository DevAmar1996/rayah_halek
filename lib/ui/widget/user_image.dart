import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final double width;
  final double height;
  final int color;
  final double padding;
  final String imageUrl;

  UserImage(this.width, this.height, this.imageUrl,
      {this.color = 0x1AFFFFFF, this.padding = 4});

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(color),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(imageUrl),
          ),
        ),
      ),
    ));
  }
}
