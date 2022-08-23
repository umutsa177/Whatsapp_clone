import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/customCard.dart';
import 'package:whatsapp_clone/models/chatModel.dart';
import 'package:whatsapp_clone/screens/selectContact.dart';

class ChatPage extends StatefulWidget {
  final List chatmodels;
  final ChatModel chatUser;

  const ChatPage({Key? key, required this.chatmodels, required this.chatUser})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectContact(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.edit),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => CustomCard(
          chatsModel: widget.chatmodels[index],
          chatUser: widget.chatUser,
        ),
      ),
    );
  }
}
