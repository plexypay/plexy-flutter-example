// ignore_for_file: unused_local_variable

import 'package:plexy_checkout/plexy_checkout.dart';
import 'package:plexy_checkout_example/config.dart';
import 'package:plexy_checkout_example/repositories/plexy_instant_component_repository.dart';
import 'package:plexy_checkout_example/utils/dialog_builder.dart';
import 'package:flutter/material.dart';

class InstantAdvancedComponentScreen extends StatelessWidget {
  const InstantAdvancedComponentScreen({
    required this.repository,
    super.key,
  });

  final PlexyInstantComponentRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plexy instant component')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            _buildPlexyGooglePayAdvancedComponent(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlexyGooglePayAdvancedComponent() {
    return FutureBuilder<Map<String, dynamic>>(
      future: repository.fetchPaymentMethods(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          final AdvancedCheckout advancedCheckout = AdvancedCheckout(
            onSubmit: repository.onSubmit,
            onAdditionalDetails: repository.onAdditionalDetails,
          );

          final InstantComponentConfiguration instantComponentConfiguration =
              InstantComponentConfiguration(
            environment: Config.environment,
            clientKey: Config.clientKey,
            countryCode: Config.countryCode,
          );

          final payPalPaymentMethodResponse =
              _extractPaymentMethod(snapshot.data!, "paypal");
          final klarnaPaymentMethodResponse =
              _extractPaymentMethod(snapshot.data!, "klarna");
          final idealPaymentMethodResponse =
              _extractPaymentMethod(snapshot.data!, "ideal");

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                style: TextStyle(fontSize: 20),
                "Advanced flow",
              ),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: () {
                    PlexyCheckout.advanced
                        .startInstantComponent(
                      configuration: instantComponentConfiguration,
                      paymentMethod: payPalPaymentMethodResponse,
                      checkout: advancedCheckout,
                    )
                        .then((paymentResult) {
                      if (context.mounted) {
                        DialogBuilder.showPaymentResultDialog(
                            paymentResult, context);
                      }
                    });
                  },
                  child: const Text("Paypal")),
              TextButton(
                  onPressed: () {
                    PlexyCheckout.advanced
                        .startInstantComponent(
                      configuration: instantComponentConfiguration,
                      paymentMethod: klarnaPaymentMethodResponse,
                      checkout: advancedCheckout,
                    )
                        .then((paymentResult) {
                      if (context.mounted) {
                        DialogBuilder.showPaymentResultDialog(
                            paymentResult, context);
                      }
                    });
                  },
                  child: const Text("Klarna")),
              TextButton(
                  onPressed: () {
                    PlexyCheckout.advanced
                        .startInstantComponent(
                      configuration: instantComponentConfiguration,
                      paymentMethod: idealPaymentMethodResponse,
                      checkout: advancedCheckout,
                    )
                        .then((paymentResult) {
                      if (context.mounted) {
                        DialogBuilder.showPaymentResultDialog(
                            paymentResult, context);
                      }
                    });
                  },
                  child: const Text("iDEAL"))
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Map<String, dynamic> _extractPaymentMethod(
      Map<String, dynamic> paymentMethods, String key) {
    return paymentMethods["paymentMethods"].firstWhere(
      (paymentMethod) => paymentMethod["type"] == key,
      orElse: () => <String, dynamic>{},
    );
  }
}
