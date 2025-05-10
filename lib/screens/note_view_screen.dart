import 'package:flutter/material.dart';

class NoteViewScreen extends StatefulWidget {
  const NoteViewScreen({super.key});

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
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
                      IconButton(onPressed: () => {}, icon: Icon(Icons.delete, color: Colors.red,)),
                      IconButton(onPressed: () => {}, icon: Icon(Icons.edit, color: Colors.blue,)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "How to learn programming?",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "Building a mobile app is a multifaceted journey that involves creativity, technical skills, and persistent problem-solving. "
                    "From the inception of the idea to its execution, developers must go through a series of stages that require collaboration, "
                    "user research, and continuous improvement.\n\n"
                    "The first step is ideation, where you determine the purpose of your app, your target audience, and the core features. "
                    "This phase often includes brainstorming sessions, competitor analysis, and outlining the problem your app is aiming to solve.\n\n"
                    "Once the idea is solidified, the next phase is design. User experience (UX) and user interface (UI) design play a crucial role here. "
                    "Tools like Figma or Adobe XD are used to create wireframes and high-fidelity prototypes that reflect how users will interact with the app.\n\n"
                    "After design comes development. Using frameworks like Flutter allows developers to create apps for both iOS and Android from a single codebase. "
                    "During this stage, you’ll work on implementing the UI, managing state, integrating APIs, and ensuring performance optimization.\n\n"
                    "Testing is an ongoing process throughout development. From unit testing to integration and user testing, this phase helps identify and fix bugs, "
                    "improve usability, and ensure stability.\n\n"
                    "Once the app is stable, it's time to deploy. The app is submitted to the App Store and Google Play Store, adhering to platform-specific guidelines "
                    "and requirements. Even after release, the journey continues through updates, bug fixes, and feature enhancements based on user feedback.\n\n"
                    "In summary, building a mobile app is not just about coding — it's about delivering value, creating delightful user experiences, and continuously evolving "
                    "to meet user needs."
                    "In summary, building a mobile app is not just about coding — it's about delivering value, creating delightful user experiences, and continuously evolving "
                    "to meet user needs."
                    "In summary, building a mobile app is not just about coding — it's about delivering value, creating delightful user experiences, and continuously evolving "
                    "to meet user needs.",
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
