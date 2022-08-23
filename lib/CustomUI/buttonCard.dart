import 'package:flutter/material.dart';
//import 'package:whatsapp_clone/models/chatModel.dart';

class ButtonCard extends StatelessWidget {
  final String name;
  final IconData icon;

  const ButtonCard({Key? key, required this.name, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.blueGrey[100],
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
