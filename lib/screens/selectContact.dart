import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/buttonCard.dart';
import 'package:whatsapp_clone/CustomUI/contactCard.dart';
import 'package:whatsapp_clone/models/chatModel.dart';
import 'package:whatsapp_clone/Screens/CreateGroup.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Olds",
      status: "How old are you?",
      currentMessage: '',
      icon: const Icon(Icons.history),
      id: 1,
      isGroup: true,
      time: '',
    ),
    ChatModel(
      name: "OS Technology",
      status: "IT Services",
      currentMessage: '',
      icon: const Icon(Icons.history),
      id: 2,
      isGroup: true,
      time: '',
    ),
    ChatModel(
      name: "Youngs",
      status: "You, Artists & Vendors",
      currentMessage: '',
      icon: const Icon(Icons.history),
      id: 3,
      isGroup: true,
      time: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "100 Contacts",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 27,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // ignore: avoid_print
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "Invite a friend",
                  child: Text("Invite friends"),
                ),
                const PopupMenuItem(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                const PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                const PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateGroup()));
              },
              child: const ButtonCard(
                icon: Icons.group,
                name: "New Group",
              ),
            );
          } else if (index == 1) {
            return const ButtonCard(
              icon: Icons.person_add,
              name: "New Contact",
            );
          }
          return Contactcard(
            contact: contacts[index - 2],
          );
        },
      ),
    );
  }
}
