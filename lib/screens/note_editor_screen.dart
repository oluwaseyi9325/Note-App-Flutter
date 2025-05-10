import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
  String selectedCategory = "";
  List<String> categories = ["Important", "Dairy", "Todo", "Lecture Notes"];

  Future<void> hanndleAddNote() async {
    if (title.text.isEmpty || body.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Pls enter your notes details!')));
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> getPreviousStore = prefs.getStringList("notes") ?? [];

    Map<String, String> newNote = {
      'title': title.text,
      'body': body.text,
      'category': selectedCategory,
      'createdAt': DateFormat('dd MMM yyyy, h:mm a').format(DateTime.now()),
      "updatedAt": DateFormat('dd MMM yyyy, h:mm a').format(DateTime.now()),
      "id": Random().nextInt(100000).toString(),
    };

    getPreviousStore.add(jsonEncode(newNote));
    await prefs.setStringList("notes", getPreviousStore);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Note saved!')));

    title.clear();
    body.clear();

    setState(() {
      selectedCategory = "";
    });
  }

  void handBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final categoryData = categories[index];
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(categoryData),
                          trailing: Icon(Icons.circle_outlined),
                          onTap: () {
                            // Handle category selection
                            setState(() {
                              selectedCategory = categoryData;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        // Divider(height: 1),
                      ],
                    );
                  },
                ),
              ),
              // Add your category options here
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_back)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.download),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.edit, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: title,
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: handBottomSheet, // Open bottom sheet when tapped
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category: $selectedCategory',
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: body,
                      maxLines: 20,
                      decoration: InputDecoration(
                        hintText: "Body of your note...",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: hanndleAddNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        child: Text(
                          "Save Note",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
