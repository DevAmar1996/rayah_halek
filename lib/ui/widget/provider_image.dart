import 'dart:io';

import 'package:flutter/material.dart';

class ProviderImage extends StatelessWidget {
  final int textColor;
  final double size;
  final double padding;
  final String path;
  final File file;

  ProviderImage(this.textColor,
      {this.size = 64, this.padding = 2, this.path = "",this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: Color(textColor), width: 1),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: file == null ? NetworkImage(path): FileImage(file), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
