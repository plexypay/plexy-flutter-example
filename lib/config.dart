import 'package:adyen_checkout/adyen_checkout.dart';

class Config {
  /*
  Your `CLIENT_KEY` and `X_API_KEY` are sensitive credentials that must be secure.

  Do not provide them in your live environment through constants, because this is not secure. Instead, provide them dynamically from your server-side.

  For testing the example app, create a `secrets.json` file that contains the following properties:
  {
    "CLIENT_KEY" : "YOUR_CLIENT_KEY",
    "X_API_KEY" : "YOUR X_API_KEY"
    "APPLE_PAY_MERCHANT_ID_KEY": "YOUR_APPLE_PAY_MERCHANT_ID_KEY"
  }
  */
  static const String clientKey = String.fromEnvironment('CLIENT_KEY', defaultValue: 'test_XYQBCT3I6JGRNADZVTUKAEDZPUTFMBUI');
  static const String xApiKey = String.fromEnvironment('X_API_KEY', defaultValue: 'AQEjhmfuXNWTK0Qc+iSAnmEgvvSaUQ0hXi//KFMJo5Im03FQWWEQwV1bDb7kfNy1WIxIIkxgBw==-i+CDH7Jb1BrchS4LBJTp1nZw1au6rq2l8ZBtKA2M/cE=-i1ixw5k>H:E?rj4%?5g');
  static const String merchantId =
      String.fromEnvironment('APPLE_PAY_MERCHANT_ID_KEY', defaultValue: 'PlexypayECOM');
  static const String publicKey = String.fromEnvironment('PUBLIC_KEY');

  //Environment constants
  static const String merchantAccount = "PlexypayECOM";
  static const String merchantName = "PlexypayECOM";
  static const String countryCode = "PL";
  static const String shopperLocale = "ru-RU";
  static const String shopperReference = "Test reference";
  static const Environment environment = Environment.test;
  static const String baseUrl = "checkout-test.adyen.com";
  static const String apiVersion = "v71";
  static const String iOSReturnUrl = "com.mydomain.adyencheckout://";
  static const GooglePayEnvironment googlePayEnvironment =
      GooglePayEnvironment.test;

  //Example data
  static Amount amount = Amount(currency: "EUR", value: 11295);
}
