import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Professional CV',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: CVPage(
        onToggleTheme: _toggleTheme,
        themeMode: _themeMode,
      ),
    );
  }
}

class CVPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const CVPage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onToggleTheme,
        icon: Icon(
          themeMode == ThemeMode.dark
              ? Icons.wb_sunny
              : Icons.nightlight_round,
        ),
        label:
            Text(themeMode == ThemeMode.dark ? 'Light Mode' : 'Dark Mode'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ================= HEADER =================
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 16),
            const Text(
              "SEAB Raksmey",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Telecommunication & Networking Student",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              alignment: WrapAlignment.center,
              children: [
                infoChip(Icons.email, "raksmeyseab11@gmail.com",
                    "mailto:raksmeyseab11@gmail.com"),
                infoChip(Icons.calendar_month, "January 10, 2026", null),
              ],
            ),

            const SizedBox(height: 30),

            // ================= PROFILE =================
            sectionTitle("Professional Profile", Icons.description),
            const Text(
              "Telecommunication and Networking student specializing in "
              "telecom networks and electronics. Seeking an internship to "
              "apply technical knowledge, gain hands-on experience, and "
              "develop professional skills in a real-world engineering "
              "environment.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),

            // ================= PERSONAL INFO =================
            sectionTitle("Personal Information", Icons.info),
            infoCard("Name", "សៀប​ រស្មី (SEAB Raksmey)"),
            infoCard("Address", "Toul Kork, Phnom Penh, Cambodia"),
            infoCard("Date of Birth", "03 October 2005"),
            infoCard("Phone", "+855 97 292 2638"),
            infoCard("Languages",
                "Khmer (Native)\nEnglish (Intermediate)\nFrench (Basic)"),

            const SizedBox(height: 30),

            // ================= SKILLS =================
            sectionTitle("Technical Skills", Icons.code),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                skillChip("C"),
                skillChip("C++"),
                skillChip("Java"),
                skillChip("ADS"),
                skillChip("FPGA"),
                skillChip("Cisco Packet Tracer"),
                skillChip("MATLAB"),
                skillChip("Flutter"),
              ],
            ),

            const SizedBox(height: 30),

            // ================= EDUCATION =================
            sectionTitle("Education Background", Icons.school),
            infoCard("Hun Sen Teuk Khleang High School", "2020 – 2022"),
            infoCard("Institute of Technology of Cambodia", "2022 – Present"),
            infoCard("Paňñāsāstra University of Cambodia", "2024 – Present"),

            const SizedBox(height: 30),

            // ================= EXPERIENCE =================
            sectionTitle("Internship Experience", Icons.work),
            infoCard("Company", "ElecTech Solar"),
            infoCard("Duration", "July 2025 – October 2025"),
            infoCard("Training",
                "Solar Panel Installation and Maintenance"),
            infoCard("Certificate",
                "Completed Internship at ElecTech Solar"),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ================= WIDGETS =================

Widget sectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget infoCard(String title, String value) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      title: Text(title),
      subtitle: Text(value),
    ),
  );
}

Widget infoChip(IconData icon, String text, String? link) {
  return ActionChip(
    avatar: Icon(icon, size: 18),
    label: Text(text),
    onPressed: link == null
        ? null
        : () async {
            final uri = Uri.parse(link);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
  );
}

class skillChip extends StatelessWidget {
  final String text;
  const skillChip(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor:
          Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
