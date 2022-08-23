import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chatModel.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.contact}) : super(key: key);

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 33,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueGrey[100],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 15,
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            contact.name,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
