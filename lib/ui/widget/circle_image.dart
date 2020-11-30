import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';

class CircleImage extends StatefulWidget {
  final File image;

  CircleImage(this.image);

  @override
  _CircleImageState createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(
          width: 110,
          height: 110,
          padding: EdgeInsets.all(
            5,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Color(
                AppColors.transparentWhite2,
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Image(
              image: widget.image == null
                  ? AssetImage(
                      AppThemeData.imagePath + "user_default.png",
                    )
                  : FileImage(
                      widget.image,
                    ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -2,
          right: 4,
          child: Icon(
            Icons.add_circle,
            color: Color(
              AppColors.purpleImageColor,
            ),
          ),
        )
      ],
    );
  }
}
