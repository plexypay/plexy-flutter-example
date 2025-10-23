import 'package:plexy_checkout/plexy_checkout.dart';
import 'package:plexy_checkout_example/config.dart';
import 'package:plexy_checkout_example/repositories/plexy_base_repository.dart';

class PlexyCseRepository extends PlexyBaseRepository {
  PlexyCseRepository({required super.service});

  Future<Map<String, dynamic>> payments({
    required EncryptedCard encryptedCard,
    String? threeDS2SdkVersion,
  }) async {
    String returnUrl = await determineBaseReturnUrl();
    returnUrl += "/plexyPayment";
    final requestBody = <String, Object>{
      "amount": {"currency": "EUR", "value": 10000},
      "reference": "flutter-test_${DateTime.now().millisecondsSinceEpoch}",
      "paymentMethod": {
        "type": "scheme",
        "encryptedCardNumber": "${encryptedCard.encryptedCardNumber}",
        "encryptedExpiryMonth": "${encryptedCard.encryptedExpiryMonth}",
        "encryptedExpiryYear": "${encryptedCard.encryptedExpiryYear}",
        "encryptedSecurityCode": "${encryptedCard.encryptedSecurityCode}",
        if (threeDS2SdkVersion != null)
          "threeDS2SdkVersion": threeDS2SdkVersion,
      },
      "authenticationData": {
        "threeDSRequestData": {"nativeThreeDS": "preferred"}
      },
      "channel": determineChannel(),
      "returnUrl": returnUrl,
      "merchantAccount": Config.merchantAccount
    };

    return await service.postPayments(requestBody);
  }

  Future<Map<String, dynamic>> paymentsDetails(
      Map<String, dynamic> detailsRequestBody) async {
    return await service.postPaymentsDetails(detailsRequestBody);
  }

  Future<Map<String, dynamic>> cardDetails(String encryptedCardNumber) async {
    final requestBody = {
      "merchantAccount": Config.merchantAccount,
      "encryptedCardNumber": encryptedCardNumber,
    };
    return await service.postCardDetails(requestBody);
  }
}
