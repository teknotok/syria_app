import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: const SyriaApp(),
    ),
  );
}

class SyriaApp extends StatelessWidget {
  const SyriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: tr('app_name'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreen(),
    );
  }
}
