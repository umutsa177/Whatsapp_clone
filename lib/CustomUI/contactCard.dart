import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chatModel.dart';

class Contactcard extends StatelessWidget {
  const Contactcard({Key? key, required this.contact}) : super(key: key);
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blueGrey[100],
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            contact.select
                ? const Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.tealAccent,
                      radius: 12,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      subtitle: Text(
        contact.status,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
