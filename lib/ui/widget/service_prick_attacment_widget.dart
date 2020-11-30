import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/provider/attachment_model.dart';
import 'package:rayahhalekapp/ui/widget/attachment_widget.dart';

import 'component/app_text.dart';

class ServicePickAttachmentWidget extends StatefulWidget {
  final int textColor;

  ServicePickAttachmentWidget(this.textColor);

  @override
  _ServicePickAttachmentWidgetState createState() =>
      _ServicePickAttachmentWidgetState();
}

class _ServicePickAttachmentWidgetState
    extends State<ServicePickAttachmentWidget> {
  List<File> files = List<File>();

  final picker = ImagePicker();
  final myTween = Tween<Offset>(
    begin: const Offset(-1.0, 0.0),
    end: Offset.zero,
  );
  final fade = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero,
  );
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  var isContainFiles = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          AppLocalization.of(context).translate("attachments"),
          FontWeight.w500,
          15,
          widget.textColor,
          TextAlign.start,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            getImage();
          },
          child: Container(
            decoration: AppThemeData.serviceDetailBoxDecoration(),
            width: MediaQuery.of(context).size.width,
            height: 168,
            padding: EdgeInsets.only(
              top: 29,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image(
                  image: AssetImage(
                    AppThemeData.imagePath + "pick_photo.png",
                  ),
                  height: 85.38,
                  width: 106.73,
                ),
                Container(
                  height: 33,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6)),
                    color: Color(
                      AppColors.borderGray,
                    ),
                  ),
                  child: Center(
                    child: AppText(
                      AppLocalization.of(context)
                          .translate("attach_image_video"),
                      FontWeight.w500,
                      13,
                      AppColors.hintGray,
                      TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: isContainFiles ? 95 : 0,
          child: AnimatedList(
            key: _listKey,
            initialItemCount: files.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                position: animation.drive(myTween),
                child: AttachmentWidget(() {
                  var file = files.removeAt(index);
                  Provider.of<AttachmentModel>(context, listen: false)
                      .changeAttachments(files);
                  AnimatedListRemovedItemBuilder builder =
                      (context, animation) {
                    // A method to build the Card widget.
                    return SlideTransition(
                        position: animation.drive(myTween),
                        child: AttachmentWidget(
                          () {},
                          file: file,
                        ));
                  };
                  _listKey.currentState.removeItem(index, builder);
                }, file: files[index]),
              );
            },
          ),
        )
      ],
    );
  }

  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future getImage() async {
    var pickFile = await picker.getImage(source: ImageSource.gallery);
    File file = await compressImage(File(pickFile.path));

    files.add(file);
    _listKey.currentState.insertItem(files.length - 1);
    Provider.of<AttachmentModel>(context, listen: false)
        .changeAttachments(files);
    print(files.length);
    setState(() {
      isContainFiles = true;
    });

    // If the widget was
  }

  Future<File> compressImage(File file) async {
    // Get file path
    // eg:- "Volume/VM/abcd.jpeg"
    final filePath = file.absolute.path;
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    return await FlutterImageCompress.compressAndGetFile(filePath, outPath,
        minWidth: 300, minHeight: 300, quality: 50);
  }
}
