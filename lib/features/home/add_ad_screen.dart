import 'package:flutter/material.dart';
import '../../models/ad.dart';
import '../widgets/add_ad_image_picker.dart';
import 'dart:typed_data'; // لـ Uint8List

class AddAdScreen extends StatefulWidget {
  final Function(Ad) onAdAdded;
  const AddAdScreen({super.key, required this.onAdAdded});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  Uint8List? _adImageBytes;
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String imageUrl = '';
  String price = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة إعلان')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'العنوان'),
                validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال العنوان' : null,
                onSaved: (value) => title = value ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'الوصف'),
                validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال الوصف' : null,
                onSaved: (value) => description = value ?? '',
              ),
              const SizedBox(height: 16),
              AddAdImagePicker(
                onImageSelected: (imgBytes) {
                  setState(() {
                    _adImageBytes = imgBytes;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'رابط الصورة (اختياري - من الإنترنت)'),
                onSaved: (value) => imageUrl = value ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'السعر'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال السعر' : null,
                onSaved: (value) => price = value ?? '',
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // يمكنك الآن استخدام _adImageBytes (الصورة النهائية المضغوطة)
                    // إذا كنت سترفعها لسيرفر أو تخزنها مع الإعلان
                    // مثال مبدئي:
                    final ad = Ad(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: title,
                      description: description,
                      // الصورة يمكنك إرسالها كبيانات base64 أو رفعها في API
                      imageUrl: '', // ستحددها لاحقًا حسب تخزينك الفعلي
                      price: double.tryParse(price) ?? 0,
                    );
                    widget.onAdAdded(ad);
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('نشر الإعلان'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
