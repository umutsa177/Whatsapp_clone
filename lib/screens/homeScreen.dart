import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chatModel.dart';
import 'package:whatsapp_clone/pages/cameraPage.dart';
import 'package:whatsapp_clone/pages/chat.dart';
import 'package:whatsapp_clone/pages/statusPage.dart';

class HomeScreen extends StatefulWidget {
  final List chatModels;
  final ChatModel chatUser;

  const HomeScreen({Key? key, required this.chatModels, required this.chatUser})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Whatsapp Clone"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
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
                  value: "New group",
                  child: Text("New Group"),
                ),
                const PopupMenuItem(
                  value: "New broadcast",
                  child: Text("New Broadcast"),
                ),
                const PopupMenuItem(
                  value: "Linked devices",
                  child: Text("Linked Devices"),
                ),
                const PopupMenuItem(
                  value: "Starred messages",
                  child: Text("Starred Messages"),
                ),
                const PopupMenuItem(
                  value: "settings",
                  child: Text("Settings"),
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Status",
            ),
            Tab(
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const CameraPage(),
          ChatPage(
            chatmodels: widget.chatModels,
            chatUser: widget.chatUser,
          ),
          const StatusPage(),
          const Center(
            child: Text(
              "Calls",
              style: TextStyle(
                fontSize: 35,
                color: Colors.indigoAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
