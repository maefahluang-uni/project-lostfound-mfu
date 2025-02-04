import 'package:flutter/material.dart';

class SelectInputScreen extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelect;

  const SelectInputScreen({
    super.key,
    required this.title,
    required this.options,
    required this.onSelect,
  });

  @override
  _SelectInputScreenState createState() => _SelectInputScreenState();
}

class _SelectInputScreenState extends State<SelectInputScreen> {
  String searchQuery = "";
  late List<String> filteredOptions;

  @override
  void initState() {
    super.initState();
    filteredOptions = widget.options;
  }

  void filterOptions(String query) {
    setState(() {
      searchQuery = query;
      filteredOptions = widget.options
          .where((option) => option.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterOptions,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredOptions.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredOptions[index],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  leading:
                      const Icon(Icons.label_important, color: Colors.blue),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    widget.onSelect(filteredOptions[index]);
                    Navigator.pop(context);
                  },
                  tileColor: Colors.grey[200], // Slight background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Cancel"),
            ),
          ),
        ],
      ),
    );
  }
}
