import 'package:cloud_firestore/cloud_firestore.dart';
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final ad = Ad(
                      id: '', // Firestore سيعطيك id لاحقًا
                      title: title,
                      description: description,
                      imageUrl: imageUrl, // أو رابط الصورة من الجهاز/الكاميرا
                      price: double.tryParse(price) ?? 0,
                    );
                    Navigator.pop(context);
                    await saveAdToFirestore(ad);
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

Future<void> saveAdToFirestore(Ad ad) async {
  await FirebaseFirestore.instance.collection('ads').add({
    'title': ad.title,
    'description': ad.description,
    'imageUrl': ad.imageUrl,
    'price': ad.price,
    'createdAt': FieldValue.serverTimestamp(),
  });
}
