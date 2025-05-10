import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final _random = Random();

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                     final Color randomColor =_cardColors[_random.nextInt(_cardColors.length)];
                    return Container(
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
                            'Note Title $index',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            'This is the content of note $index. This is the content of note $index. This is the content of note $index. This is the content of note $index. This is the content of note $index.',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
