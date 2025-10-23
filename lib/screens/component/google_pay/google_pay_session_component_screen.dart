// ignore_for_file: unused_local_variable

import 'package:plexy_checkout/plexy_checkout.dart';
import 'package:plexy_checkout_example/config.dart';
import 'package:plexy_checkout_example/repositories/plexy_google_pay_component_repository.dart';
import 'package:plexy_checkout_example/utils/dialog_builder.dart';
import 'package:flutter/material.dart';

class GooglePaySessionsComponentScreen extends StatelessWidget {
  const GooglePaySessionsComponentScreen({
    required this.repository,
    super.key,
  });

  final PlexyGooglePayComponentRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plexy google pay component')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            _buildPlexyGooglePaySessionComponent()
          ],
        ),
      ),
    );
  }

  Widget _buildPlexyGooglePaySessionComponent() {
    final GooglePayComponentConfiguration googlePayComponentConfiguration =
        GooglePayComponentConfiguration(
      environment: Config.environment,
      clientKey: Config.clientKey,
      countryCode: Config.countryCode,
      googlePayConfiguration: const GooglePayConfiguration(
        googlePayEnvironment: Config.googlePayEnvironment,
      ),
    );

    return FutureBuilder<SessionCheckout>(
      future: repository.createSessionCheckout(googlePayComponentConfiguration),
      builder: (BuildContext context, AsyncSnapshot<SessionCheckout> snapshot) {
        if (snapshot.hasData) {
          final SessionCheckout sessionCheckout = snapshot.data!;
          final paymentMethod =
              _extractPaymentMethod(sessionCheckout.paymentMethods);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                style: TextStyle(fontSize: 20),
                "Session flow",
              ),
              const SizedBox(height: 8),
              PlexyGooglePayComponent(
                configuration: googlePayComponentConfiguration,
                paymentMethod: paymentMethod,
                checkout: sessionCheckout,
                loadingIndicator: const CircularProgressIndicator(),
                onPaymentResult: (paymentResult) {
                  Navigator.pop(context);
                  DialogBuilder.showPaymentResultDialog(paymentResult, context);
                },
                unavailableWidget:
                    const Text("Google Pay is unavailable on this device"),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Map<String, dynamic> _extractPaymentMethod(
      Map<String, dynamic> paymentMethods) {
    if (paymentMethods.isEmpty) {
      return <String, String>{};
    }

    return paymentMethods["paymentMethods"].firstWhere(
      (paymentMethod) => paymentMethod["type"] == "googlepay",
      orElse: () => throw Exception("Google pay payment method not provided"),
    );
  }
}
