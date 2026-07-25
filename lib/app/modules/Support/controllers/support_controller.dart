import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final String whatsappNumber = "918239784975";

  Future<void> openWhatsApp() async {
    final uri = Uri.parse("https://wa.me/$whatsappNumber");
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }
}
