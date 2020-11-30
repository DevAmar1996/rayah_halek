
import 'dart:io';

import 'package:flutter/cupertino.dart';

class AttachmentModel extends ChangeNotifier {
  List<File> file = [];

  void changeAttachments(List<File> file) {
    this.file = file;
  }
}
