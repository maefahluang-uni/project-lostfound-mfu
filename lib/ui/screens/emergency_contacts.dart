import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({super.key});

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  final List<Map<String, String>> contacts = const [
    {'building': 'AS Building', 'phone': '123-456-7890'},
    {'building': 'C1 Building', 'phone': '234-567-8901'},
    {'building': 'C2 Building', 'phone': '345-678-9012'},
    {'building': 'C3 Building', 'phone': '456-789-0123'},
    {'building': 'C4 Building', 'phone': '567-890-1234'},
    {'building': 'D1 Building', 'phone': '678-901-2345'},
    {'building': 'E1 Building', 'phone': '789-012-3456'},
    {'building': 'E2 Building', 'phone': '890-123-4567'},
    {'building': 'E3 Building', 'phone': '901-234-5678'},
    {'building': 'E4 Building', 'phone': '012-345-6789'},
    {'building': 'F Dormitory', 'phone': '111-222-3333'},
    {'building': 'Lamduan Dormitory', 'phone': '222-333-4444'},
    {'building': 'Learning Space', 'phone': '333-444-5555'},
    {'building': 'MFU Library', 'phone': '444-555-6666'},
    {'building': 'M Square', 'phone': '555-666-7777'},
    {'building': 'S1 Building', 'phone': '666-777-8888'},
    {'building': 'S7 Building', 'phone': '777-888-9999'},
    {'building': 'Sathorn Dormitory', 'phone': '888-999-0000'},
    {'building': 'MFU Sport Complex', 'phone': '999-000-1111'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppbar(appBarTitle: "Emergency Contacts", hasBackArrow: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return EmergencyContactCard(
            building: contacts[index]['building']!,
            phone: contacts[index]['phone']!,
          );
        },
      ),
    );
  }
}

class EmergencyContactCard extends StatelessWidget {
  final String building;
  final String phone;

  const EmergencyContactCard({
    super.key,
    required this.building,
    required this.phone,
  });

  void _makeCall(String phoneNumber) {
    // You can integrate phone call functionality using url_launcher here
    print('Calling $phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.security, color: Colors.redAccent),
        title:
            Text(building, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Phone: $phone'),
        trailing: IconButton(
          icon: const Icon(Icons.call, color: Colors.green),
          onPressed: () => _makeCall(phone),
        ),
      ),
    );
  }
}
