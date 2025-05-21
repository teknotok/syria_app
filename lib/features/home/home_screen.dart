import 'package:flutter/material.dart';
import '../../models/ad.dart';
import 'ad_detail_screen.dart'; // أضف هذا الاستيراد في الأعلى

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // قائمة إعلانات وهمية للاختبار
  final List<Ad> ads = [
    Ad(
      id: '1',
      title: 'سيارة كيا ريو 2015',
      description: 'بحالة ممتازة، مكيفة، السعر قابل للتفاوض.',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      price: 15000,
    ),
    Ad(
      id: '2',
      title: 'شقة للبيع في دمشق',
      description: '3 غرف وصالون، بناء حديث، قريب من الخدمات.',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      price: 50000,
    ),
    Ad(
      id: '3',
      title: 'هاتف سامسونج S22 جديد',
      description: 'مغلف بكرتونته، مع كفالة.',
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      price: 900,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعلانات سوريا')),
      body: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (context, index) {
          final ad = ads[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(ad.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(ad.title),

              subtitle: Text(ad.description),
              trailing: Text('${ad.price} \$', style: const TextStyle(fontWeight: FontWeight.bold)),
              // داخل ListTile:
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdDetailScreen(ad: ad)));
              },
            ),
          );
        },
      ),
    );
  }
}
