import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/models/post_item.dart';
import 'package:lost_found_mfu/ui/screens/detail.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();

  List<Item> items = [
    Item(
      id: 1,
      item: "Macbook",
      status: "Found",
      color: "Gold",
      date: DateTime(2025, 1, 20),
      time: "20:31",
      location: "C1/313",
      phoneNumber: "0997820067",
      description:
          "I found this MacBook in the classroom C1/313. If you are the owner or friend with owner, please contact me.",
      images: [
        "https://example.com/macbook.jpg",
      ],
    ),
    Item(
      id: 2,
      item: "Black wallet",
      status: "Found",
      color: "Black",
      date: DateTime(2025, 1, 10),
      time: "15:00",
      location: "Library",
      phoneNumber: "0881234567",
      description: "Found in the library, contact for details.",
      images: [
        "https://example.com/wallet.jpg",
      ],
    ),
  ];

  List<Item> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void filterSearch(String query) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: CustomTextField(
              controller: _searchController,
              label: "Search items",
              prefixIcon: Icons.search,
              onChanged: filterSearch,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Result",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListTile(
                    title: Text(item.item,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "Found in ${item.location} on ${item.date.month}/${item.date.day}"),
                    trailing:
                        const Icon(Icons.arrow_forward, color: Colors.black),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(item: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
