import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/screens/note_editor_screen.dart';
import 'package:note_app/screens/note_view_screen.dart';
import 'package:note_app/widget/home_header.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _random = Random();

  List<Map<String, dynamic>> notes = [];

  Future<void> fetchNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedNotes = prefs.getStringList("notes") ?? [];

    List<Map<String, dynamic>> loadedNotes =
        savedNotes.map((noteJson) {
          return jsonDecode(noteJson) as Map<String, dynamic>;
        }).toList();

    setState(() {
      notes = loadedNotes;
    });
  }

  final List<Color> _cardColors = [
    Color(0xFFCDDCFD),
    Color(0xFFFFD8F4),
    Color(0xFFFBF6AA),
    Color(0xFFB0E9CA),
    Color(0xFFFCFAD9),
    Color(0xFFF1DBF5),
    Color(0xFFD9E8FC),
    Color(0xFFFFDBE3),
  ];
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  // controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search notes...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    // You can add filtering logic here
                  },
                ),
              ),
              HomeHeader(),
              SizedBox(height: 16.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final Color randomColor =
                        _cardColors[_random.nextInt(_cardColors.length)];
                    final myNote = notes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteViewScreen(note: myNote),
                          ),
                        );
                      },
                      child: Container(
                        // margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(10.0),
                        // height: 100,
                        decoration: BoxDecoration(
                          color: randomColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myNote['title']??"",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              myNote['body'],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEditorScreen()),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }
}
