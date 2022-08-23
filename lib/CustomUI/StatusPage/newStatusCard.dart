import 'package:flutter/material.dart';

class NewStatusCard extends StatelessWidget {
  const NewStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blueGrey,
            backgroundImage: null,
            child: Icon(
              Icons.person,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.cyan.shade300,
              radius: 15,
              child: const Icon(
                Icons.add,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      title: const Text(
        "Status",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        "Add status update",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}
