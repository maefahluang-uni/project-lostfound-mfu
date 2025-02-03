import 'package:flutter/material.dart';
import '../../models/post_item.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Haruto Tanaka',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Item : ${item.item}", style: const TextStyle(fontSize: 16)),
            Text("Status : ${item.status}",
                style: const TextStyle(fontSize: 16)),
            Text("Color : ${item.color}", style: const TextStyle(fontSize: 16)),
            Text("Date : ${item.date.month}/${item.date.day}/${item.date.year}",
                style: const TextStyle(fontSize: 16)),
            Text("Time : ${item.time}", style: const TextStyle(fontSize: 16)),
            Text("Location : ${item.location}",
                style: const TextStyle(fontSize: 16)),
            Text("Phone Number : ${item.phoneNumber}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Description : ${item.description}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.images[index], // ✅ Load image from network
                        width: 450,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/macbook.jpg', // ✅ Fallback image if network fails
                            width: 450,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
