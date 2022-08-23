import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chatModel.dart';
import 'package:whatsapp_clone/pages/individualChats.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatsModel;
  final ChatModel chatUser;

  const CustomCard({Key? key, required this.chatsModel, required this.chatUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndividualChats(
                chatsModel: chatsModel,
                chatUser: chatUser,
              ),
            ));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.tealAccent,
              child: Icon(
                chatsModel.isGroup ? Icons.groups : Icons.person,
                color: Colors.white,
                size: 37,
              ),
            ),
            title: Text(
              chatsModel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    chatsModel.currentMessage,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Text(chatsModel.time),
          ),
          const Padding(
            padding: EdgeInsets.only(
              right: 20,
              left: 75,
            ),
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
