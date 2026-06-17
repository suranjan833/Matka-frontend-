import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final String phoneNumber = "+919071231482";
  final String whatsappNumber = "919071231482";
  final String email = "support@matkaapp.com";
  final String website = "https://matkaapp.com";

  final RxList<Map<String, dynamic>> faqList = <Map<String, dynamic>>[
    {
      "question": "How do I deposit money?",
      "answer":
          "Go to Wallet → Add Fund. Choose your preferred payment method and follow the instructions.",
      "expanded": false.obs,
    },
    {
      "question": "How do I withdraw my winnings?",
      "answer":
          "Go to Wallet → Withdraw Funds. Enter the amount and your bank details. Withdrawals are processed within 24 hours.",
      "expanded": false.obs,
    },
    {
      "question": "What is the minimum deposit?",
      "answer":
          "The minimum deposit amount is ₹100. You can deposit via UPI, Net Banking, or Wallet Transfer.",
      "expanded": false.obs,
    },
    {
      "question": "How long do withdrawals take?",
      "answer":
          "Withdrawals are typically processed within 24 hours on business days. Weekends may take slightly longer.",
      "expanded": false.obs,
    },
  ].obs;

  void toggleFaq(int index) {
    faqList[index]['expanded'].value =
        !faqList[index]['expanded'].value;
  }

  Future<void> openWhatsApp() async {
    final uri = Uri.parse("https://wa.me/$whatsappNumber");
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  Future<void> callSupport() async {
    final uri = Uri.parse("tel:$phoneNumber");
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  Future<void> sendEmail() async {
    final uri = Uri.parse("mailto:$email");
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }
}
