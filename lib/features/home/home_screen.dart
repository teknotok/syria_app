import 'package:flutter/material.dart';
import 'package:syria_app/features/home/ad_detail_screen.dart';
import 'package:syria_app/features/home/add_ad_screen.dart';
import '../../models/ad.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ads').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('لا توجد إعلانات بعد.'));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(data['imageUrl'], width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(data['title']),
                  subtitle: Text(data['description']),
                  trailing: Text('${data['price']} \$', style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdDetailScreen(adData: data), // تأكد من تحويل البيانات إلى كائن Ad
                      ),
                    );
                    // يمكنك إرسال البيانات لصفحة التفاصيل
                  },
                ),
              );
            },
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
        tooltip: 'إضافة إعلان',
        child: const Icon(Icons.add),
      ),
    );
  }
}
