import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareAppVM {
  String subject = "ShareApp";
  String body = "trialtrial";
  shareViaEmail(String toMailId) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  shareIn(String instagram) async{
    var url = instagram;

    if (await canLaunch(url)) {
      await launch(
      url,
      universalLinksOnly: true,);
    } else {
       throw 'There was a problem to open the url: $url';
    }
  }


  }