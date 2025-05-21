import 'package:flutter/material.dart';
import '../../models/ad.dart';
import 'ad_detail_screen.dart';
import 'add_ad_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Ad> ads = [
    // بيانات تجريبية...
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdDetailScreen(ad: ad),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAdScreen(
                onAdAdded: (ad) {
                  setState(() {
                    ads.add(ad);
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'إضافة إعلان',
      ),
    );
  }
}
