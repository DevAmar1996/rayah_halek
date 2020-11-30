import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';

class AttachmentWidget extends StatelessWidget {
  final File file;
  final String url;
  final Function() delete;

  AttachmentWidget(this.delete, {this.file = null, this.url = ""});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 97,
          height: 95,
          margin: EdgeInsetsDirectional.only(end: 10),
          decoration: AppThemeData.serviceDetailBoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(
                7,
              ),
            ),
            child: url == ""
                ? Image.file(
                    file,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        GestureDetector(
          onTap: () {
            delete();
          },
          child: url == ""
              ? Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsetsDirectional.only(start: 4, top: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(
                        0x54FFFFFF,
                      )),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Center(
                      child: Icon(
                        Icons.delete_forever,
                        size: 16,
                        color: Color(AppColors.deleteRedColor),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        )
      ],
    );
  }
}
