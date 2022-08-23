import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/buttonCard.dart';
import 'package:whatsapp_clone/models/chatModel.dart';
import 'package:whatsapp_clone/screens/homeScreen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ChatModel chatUser;
  List chats = [
    ChatModel(
      name: "Emily",
      id: 1,
      isGroup: false,
      currentMessage: 'Hello, welcome to Whatsapp Clone',
      time: "12:00",
      icon: const Icon(Icons.person),
      status: '',
    ),
    ChatModel(
      name: "Adams",
      id: 2,
      isGroup: false,
      currentMessage: 'Hi, i am on Whatsapp Clone',
      time: "14:00",
      icon: const Icon(Icons.person),
      status: '',
    ),
    ChatModel(
      name: "Elizabeth",
      id: 3,
      isGroup: false,
      currentMessage: 'Hook up with me on Whatsapp Clone',
      time: "09:00",
      icon: const Icon(Icons.person),
      status: '',
    ),
    ChatModel(
      name: "Kelvin",
      id: 4,
      isGroup: false,
      currentMessage: 'Hey, when\'s the time for our meeting',
      time: "19:00",
      icon: const Icon(Icons.person),
      status: '',
    ),
    ChatModel(
      name: "Lilly",
      id: 5,
      isGroup: false,
      currentMessage: 'Hello there!',
      time: "09:00",
      icon: const Icon(Icons.person),
      status: '',
    ),
    ChatModel(
      name: "Harry",
      id: 6,
      isGroup: false,
      currentMessage: 'What time is it?',
      time: "19:00",
      icon: const Icon(Icons.person),
      status: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            chatUser = chats.removeAt(index);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  chatModels: chats,
                  chatUser: chatUser,
                ),
              ),
            );
          },
          child: ButtonCard(
            name: chats[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
