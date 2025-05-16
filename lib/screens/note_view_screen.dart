import 'package:flutter/material.dart';
import 'package:note_app/widget/custom_header.dart';

class NoteViewScreen extends StatefulWidget {
  final Map<String, dynamic> note;

  // const NoteViewScreen({super.key});
  const NoteViewScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  @override
  Widget build(BuildContext context) {
    final note = widget.note;
    String createdAt = note['createdAt'] ?? '';
    String updatedAt = note['updatedAt'] ?? '';
    bool isUpdated = createdAt != updatedAt;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(note: widget.note),
              SizedBox(height: 16),
              Text(
                note['title'] ?? 'Untitled',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                isUpdated ? 'Updated at: $updatedAt' : 'Created at: $createdAt',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    note['body'] ?? '',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.5,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
