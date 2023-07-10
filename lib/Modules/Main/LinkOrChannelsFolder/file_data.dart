import 'package:flutter/material.dart';

class FileDataScreen extends StatefulWidget {
  List<Map<String, String>> titlesAndLinks;
  FileDataScreen(
    this.titlesAndLinks,
  );

  @override
  State<FileDataScreen> createState() => _FileDataScreenState();
}

class _FileDataScreenState extends State<FileDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.titlesAndLinks.length + 1,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Text(widget.titlesAndLinks[0]['title']!),
                Text(widget.titlesAndLinks[0]['link']!)
              ],
            );
          }),
    );
  }
}
