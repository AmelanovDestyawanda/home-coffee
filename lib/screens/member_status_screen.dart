import 'package:flutter/material.dart';

class MemberStatusScreen extends StatelessWidget {
  const MemberStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Status Anggota")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 100, color: Colors.amber),
            SizedBox(height: 20),
            Text("Gold Member", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Nikmati keuntungan eksklusif!"),
          ],
        ),
      ),
    );
  }
}