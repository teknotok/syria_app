import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('login'))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr('welcome'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(labelText: tr('email_or_phone'), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // ستكمل هنا لاحقاً عملية تسجيل الدخول
              },
              child: Text(tr('login')),
            ),
            ElevatedButton(
              onPressed: () {
                if (context.locale.languageCode == 'ar') {
                  context.setLocale(const Locale('en'));
                } else {
                  context.setLocale(const Locale('ar'));
                }
              },
              child: Text(context.locale.languageCode == 'ar' ? 'English' : 'العربية'),
            ),
          ],
        ),
      ),
    );
  }
}
