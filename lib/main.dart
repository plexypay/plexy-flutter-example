// ignore_for_file: unused_local_variable

import 'package:plexy_checkout/plexy_checkout.dart';
import 'package:plexy_checkout_example/network/service.dart';
import 'package:plexy_checkout_example/repositories/plexy_apple_pay_component_repository.dart';
import 'package:plexy_checkout_example/repositories/plexy_card_component_repository.dart';
import 'package:plexy_checkout_example/repositories/plexy_cse_repository.dart';
import 'package:plexy_checkout_example/repositories/plexy_drop_in_repository.dart';
import 'package:plexy_checkout_example/repositories/plexy_google_pay_component_repository.dart';
import 'package:plexy_checkout_example/repositories/plexy_instant_component_repository.dart';
import 'package:plexy_checkout_example/screens/api_only/card_state_notifier.dart';
import 'package:plexy_checkout_example/screens/api_only/custom_card_screen.dart';
import 'package:plexy_checkout_example/screens/component/apple_pay/apple_pay_advanced_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/apple_pay/apple_pay_navigation_screen.dart';
import 'package:plexy_checkout_example/screens/component/apple_pay/apple_pay_session_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/card/card_advanced_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/card/card_bottom_sheet_screen.dart';
import 'package:plexy_checkout_example/screens/component/card/card_navigation_screen.dart';
import 'package:plexy_checkout_example/screens/component/card/card_session_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/google_pay/google_pay_advanced_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/google_pay/google_pay_navigation_screen.dart';
import 'package:plexy_checkout_example/screens/component/google_pay/google_pay_session_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/instant/instant_advanced_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/instant/instant_navigation_screen.dart';
import 'package:plexy_checkout_example/screens/component/instant/instant_session_component_screen.dart';
import 'package:plexy_checkout_example/screens/component/multi_component/multi_component_advanced_screen.dart';
import 'package:plexy_checkout_example/screens/component/multi_component/multi_component_navigation_screen.dart';
import 'package:plexy_checkout_example/screens/component/multi_component/multi_component_session_screen.dart';
import 'package:plexy_checkout_example/screens/drop_in/drop_in_screen.dart';
import 'package:plexy_checkout_example/utils/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  final service = Service();
  final plexyGooglePayComponentRepository =
      PlexyGooglePayComponentRepository(service: service);
  final plexyApplePayComponentRepository =
      PlexyApplePayComponentRepository(service: service);
  final plexyCardComponentRepository =
      PlexyCardComponentRepository(service: service);
  final plexyInstantComponentRepository =
      PlexyInstantComponentRepository(service: service);
  final plexyCseRepository = PlexyCseRepository(service: service);

  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'), // English
      Locale('ar'), // Arabic
    ],
    themeMode: ThemeMode.system,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF00112C),
      brightness: Brightness.light,
    )),
    darkTheme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFEFEFEF),
        brightness: Brightness.dark,
      ),
    ),
    routes: {
      '/': (context) => const MyApp(),
      '/dropInScreen': (context) => DropInScreen(
            repository: PlexyDropInRepository(service: service),
          ),
      '/cardComponentScreen': (context) => const CardNavigationScreen(),
      '/cardSessionComponentScreen': (context) => CardSessionComponentScreen(
            repository: plexyCardComponentRepository,
          ),
      '/cardAdvancedComponentScreen': (context) => CardAdvancedComponentScreen(
            repository: plexyCardComponentRepository,
          ),
      '/cardBottomSheetScreen': (context) => CardBottomSheetScreen(
            repository: plexyCardComponentRepository,
          ),
      '/googlePayNavigation': (context) => const GooglePayNavigationScreen(),
      '/googlePaySessionComponent': (context) =>
          GooglePaySessionsComponentScreen(
            repository: plexyGooglePayComponentRepository,
          ),
      '/googlePayAdvancedComponent': (context) =>
          GooglePayAdvancedComponentScreen(
            repository: plexyGooglePayComponentRepository,
          ),
      '/applePayNavigation': (context) => const ApplePayNavigationScreen(),
      '/applePaySessionComponent': (context) => ApplePaySessionComponentScreen(
            repository: plexyApplePayComponentRepository,
          ),
      '/applePayAdvancedComponent': (context) =>
          ApplePayAdvancedComponentScreen(
            repository: plexyApplePayComponentRepository,
          ),
      '/instantComponentNavigation': (context) =>
          const InstantNavigationScreen(),
      '/instantSessionComponent': (context) => InstantSessionComponentScreen(
          repository: plexyInstantComponentRepository),
      '/instantAdvancedComponent': (context) => InstantAdvancedComponentScreen(
          repository: plexyInstantComponentRepository),
      '/multiComponentNavigationScreen': (context) =>
          const MultiComponentNavigationScreen(),
      '/multiComponentSessionScreen': (context) => MultiComponentSessionScreen(
            cardRepository: plexyCardComponentRepository,
            googlePayRepository: plexyGooglePayComponentRepository,
            applePayRepository: plexyApplePayComponentRepository,
          ),
      '/multiComponentAdvancedScreen': (context) =>
          MultiComponentAdvancedScreen(
            cardRepository: plexyCardComponentRepository,
            googlePayRepository: plexyGooglePayComponentRepository,
            applePayRepository: plexyApplePayComponentRepository,
          ),
      '/customCard': (context) => Provider(
            notifier: CardStateNotifier(plexyCseRepository),
            child: const CustomCardScreen(),
          ),
    },
    initialRoute: "/",
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PlexyCheckout.instance.enableConsoleLogging(enabled: true);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Checkout example app')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => Navigator.pushNamed(context, "/dropInScreen"),
                child: const Text("Drop-in")),
            TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/cardComponentScreen"),
                child: const Text("Card component")),
            _buildGoogleOrApplePayComponent(context),
            TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/instantComponentNavigation"),
                child: const Text("Instant component")),
            TextButton(
                onPressed: () => Navigator.pushNamed(
                    context, "/multiComponentNavigationScreen"),
                child: const Text("Multi component")),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, "/customCard"),
                child: const Text("Custom card (CSE)")),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleOrApplePayComponent(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, "/googlePayNavigation"),
            child: const Text("Google pay component"));
      case TargetPlatform.iOS:
        return TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, "/applePayNavigation"),
            child: const Text("Apple pay component"));
      default:
        return const SizedBox.shrink();
    }
  }
}
