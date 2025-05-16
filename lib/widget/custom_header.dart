// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:note_app/screens/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class CustomHeader extends StatefulWidget {
//   const CustomHeader({Key? key, required this.note}) : super(key: key);

//   final Map<String, dynamic> note;

//   @override
//   State<CustomHeader> createState() => _CustomHeaderState();
// }

// class _CustomHeaderState extends State<CustomHeader> {
//   Future<void> _deleteNote() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> savedNotes = prefs.getStringList("notes") ?? [];

//     savedNotes.removeWhere((noteJson) {
//       final note = jsonDecode(noteJson);
//       return note['id'] == widget.note['id'];
//     });

//     await prefs.setStringList("notes", savedNotes);

//     // After deleting, pop back to previous screen
//     if (context.mounted) {
//       Navigator.push(context,
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         ),
//        );
//     }
//   }

//   void _confirmDelete() {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Delete Note'),
//         content: const Text('Are you sure you want to delete this note?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(ctx).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop(); // close dialog
//               _deleteNote(); // perform deletion
//             },
//             child: const Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         Row(
//           children: [
//             IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: const Icon(Icons.download),
//             ),
//             IconButton(
//               onPressed: _confirmDelete,
//               icon: const Icon(Icons.delete, color: Colors.red),
//             ),
//             IconButton(
//               onPressed: () {
              
//               },
//               icon: const Icon(Icons.edit, color: Colors.blue),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({Key? key, required this.note}) : super(key: key);

  final Map<String, dynamic> note;

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  Future<void> _deleteNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedNotes = prefs.getStringList("notes") ?? [];

    savedNotes.removeWhere((noteJson) {
      final note = jsonDecode(noteJson);
      return note['id'] == widget.note['id'];
    });

    await prefs.setStringList("notes", savedNotes);

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteNote();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  widget.note['title'] ?? 'Untitled',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  widget.note['body'] ?? '',
                  style: pw.TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );

    // This opens the native share/save dialog (works on mobile and desktop)
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _generatePdf, // download as PDF
              icon: const Icon(Icons.download),
            ),
            IconButton(
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
            IconButton(
              onPressed: () {
                // Your edit logic here
              },
              icon: const Icon(Icons.edit, color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }
}
