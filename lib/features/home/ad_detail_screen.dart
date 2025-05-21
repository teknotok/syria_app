import 'package:flutter/material.dart';
import '../../models/ad.dart';

class AdDetailScreen extends StatelessWidget {
  final Ad ad;

  const AdDetailScreen({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ad.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                ad.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  height: 200,
                  child: const Center(child: Icon(Icons.image_not_supported, size: 60)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              ad.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              ad.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              'السعر: ${ad.price} \$',
              style: const TextStyle(fontSize: 22, color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 36),
            ElevatedButton.icon(
              onPressed: () {
                // لاحقاً: إضافة مراسلة صاحب الإعلان
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("هذه الخاصية قيد التطوير...")),
                );
              },
              icon: const Icon(Icons.chat),
              label: const Text("مراسلة البائع"),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
            ),
          ],
        ),
      ),
    );
  }
}
