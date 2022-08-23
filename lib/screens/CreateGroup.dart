import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/avatarCard.dart';
//import 'package:whatsapp_clone/CustomUI/buttonCard.dart';
import 'package:whatsapp_clone/CustomUI/contactCard.dart';
import 'package:whatsapp_clone/models/chatModel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Thomas Anderson",
      status: "My name is NEO",
      currentMessage: '',
      icon: const Icon(Icons.favorite_sharp),
      id: 1,
      isGroup: true,
      time: '',
    ),
    ChatModel(
      name: "Mr. Smith",
      status: "Hello Everybody",
      currentMessage: '',
      icon: const Icon(Icons.favorite_sharp),
      id: 2,
      isGroup: false,
      time: '',
    ),
    ChatModel(
      name: "Trinity",
      status: "How is it going?",
      currentMessage: '',
      icon: const Icon(Icons.favorite_sharp),
      id: 3,
      isGroup: false,
      time: '',
    ),
  ];

  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Add contacts to new group",
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
              size: 25,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groups.isNotEmpty ? 90 : 10,
                  );
                }
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (contacts[index - 1].select == true) {
                        groups.remove(contacts[index - 1]);
                        contacts[index - 1].select = false;
                      } else {
                        contacts[index - 1].select = true;
                        groups.add(contacts[index - 1]);
                      }
                    });
                  },
                  child: Contactcard(
                    contact: contacts[index - 1],
                  ),
                );
              }),
          groups.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 65,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  contacts[index].select = false;
                                  groups.remove(contacts[index]);
                                });
                              },
                              child: AvatarCard(
                                contact: contacts[index],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
