import 'dart:io';

import 'package:plexy_checkout/plexy_checkout.dart';
import 'package:plexy_checkout_example/config.dart';
import 'package:plexy_checkout_example/network/service.dart';
import 'package:plexy_checkout_example/utils/payment_event_handler.dart';

class PlexyBaseRepository {
  PlexyBaseRepository({
    required this.service,
  });

  final Service service;
  final PaymentEventHandler paymentEventHandler = PaymentEventHandler();

  Future<String> determineBaseReturnUrl() async {
    if (Platform.isAndroid) {
      return await PlexyCheckout.instance.getReturnUrl();
    } else if (Platform.isIOS) {
      return Config.iOSReturnUrl;
    } else {
      throw Exception("Unsupported platform");
    }
  }

  String determineChannel() {
    if (Platform.isAndroid) {
      return "Android";
    }

    if (Platform.isIOS) {
      return "iOS";
    }

    throw Exception("Unsupported platform");
  }
}
