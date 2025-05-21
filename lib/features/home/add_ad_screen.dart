import 'package:flutter/material.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  //final _fromKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String imageUrl = '';
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
