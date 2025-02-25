import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'add_contact.dart';
import 'edit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box contactsBox;
  String searchQuery = "";
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box('contacts');
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            searchQuery = result.recognizedWords.toLowerCase();
          });
        },
        listenFor: Duration(seconds: 5),
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
      searchQuery = ""; // Reset search query when stopping the microphone
    });
  }

  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  String getInitials(String name) {
    List<String> nameParts = name.split(" ");
    String initials = nameParts.map((part) => part[0]).take(2).join();
    return initials.toUpperCase();
  }

  Future<bool> _onWillPop() async {
    if (_isListening) {
      _stopListening();
      return false; // Prevent exiting the screen when the mic is active
    }
    return true; // Allow exiting normally
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contact List"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search by name or number",
                  prefixIcon: Icon(Icons.search, color: Colors.blue), // Blue search icon
                  suffixIcon: IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.blue),
                    onPressed: _toggleListening,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border on focus
                  ),
                 
                ),

              ),
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: contactsBox.listenable(),
          builder: (context, Box box, _) {
            if (box.isEmpty) {
              return Center(child: Text("No contacts available"));
            }

            final filteredContacts = box.values.where((contact) {
              final name = contact['name'].toLowerCase();
              final number = contact['number'].toLowerCase();
              return name.contains(searchQuery) || number.contains(searchQuery);
            }).toList();

            return ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade300,
                    child: Text(
                      getInitials(contact['name']),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(contact['name']),
                  subtitle: Text(contact['number']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.grey.shade400),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditContactScreen(
                                index: index,
                                name: contact['name'],
                                number: contact['number'],
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey.shade300),
                        onPressed: () => _confirmDelete(index),
                      ),
                    ],
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
              MaterialPageRoute(builder: (context) => AddContactScreen()),
            );
          },
          backgroundColor: Colors.blue, // Set button color to blue
          child: Icon(Icons.add, color: Colors.white), // Ensure the icon is visible
        ),

      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Contact"),
        content: Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              contactsBox.deleteAt(index);
              Navigator.pop(context);
              setState(() {});
            },
            child: Text("Delete", style: TextStyle(color: Colors.red.shade300)),
          ),
        ],
      ),
    );
  }
}
