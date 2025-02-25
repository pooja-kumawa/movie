import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EditContactScreen extends StatefulWidget {
  final int index;
  final String name;
  final String number;

  EditContactScreen({required this.index, required this.name, required this.number});

  @override
  _EditContactScreenState createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  late Box contactsBox;

  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box('contacts'); // Open the box
    _nameController.text = widget.name;
    _numberController.text = widget.number;
  }

  void _updateContact() {
    final String name = _nameController.text.trim();
    final String number = _numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      contactsBox.putAt(widget.index, {'name': name, 'number': number});
      Navigator.pop(context); // Return to HomeScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
        backgroundColor: Colors.blue, // Blue AppBar
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person, color: Colors.blue), // Blue icon
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border on focus
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.phone, color: Colors.blue), // Blue icon
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border on focus
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue button
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Update Contact",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
