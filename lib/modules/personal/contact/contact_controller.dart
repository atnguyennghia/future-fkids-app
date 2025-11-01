import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {
  Future<void> openUrl(String url) async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
