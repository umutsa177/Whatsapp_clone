import 'package:whatsapp_clone/models/chatModel.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/chatMessageCard.dart';
import 'package:whatsapp_clone/CustomUI/replyMessageCard.dart';
import 'package:whatsapp_clone/models/messageModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class IndividualChats extends StatefulWidget {
  final ChatModel chatsModel;
  final ChatModel chatUser;

  const IndividualChats(
      {Key? key, required this.chatsModel, required this.chatUser})
      : super(key: key);

  @override
  State<IndividualChats> createState() => _IndividualChatsState();
}

class _IndividualChatsState extends State<IndividualChats> {
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late IO.Socket socket;
  bool sendChatButton = false;
  var messages = [];

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
  }

  void connect() {
    // Heroku host https://protected-castle-55403.herokuapp.com/
    socket = IO.io("http://192.168.43.115:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("logon", widget.chatUser.id);
    socket.onConnect((data) {
      // ignore: avoid_print
      print("connected");
      socket.on("msg", (msg) {
        // ignore: avoid_print
        print(msg);
        storeReceivedMsg("receiver", msg["msg"]);
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    // ignore: avoid_print
    print(socket.connected);
  }

  void sendChatMsg(String msg, int chatUserId, int receiverId) {
    storeReceivedMsg("chatUser", msg);
    socket.emit("msg",
        {"msg": msg, "chatUserId": chatUserId, "receiverId": receiverId});
  }

  void storeReceivedMsg(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (showEmoji) {
          setState(() {
            showEmoji = false;
          });
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            leadingWidth: 65,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.cyan[100],
                    radius: 20,
                    child: Icon(
                      widget.chatsModel.isGroup ? Icons.group : Icons.person,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatsModel.name,
                      style: const TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "last seen at 15:00",
                      style: TextStyle(fontSize: 13.5),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              PopupMenuButton<String>(onSelected: (value) {
                // ignore: avoid_print
                print(value);
              }, itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: "View Contact",
                    child: Text("View Contact"),
                  ),
                  const PopupMenuItem(
                    value: "Media, links, and docs",
                    child: Text("Media, links, and docs"),
                  ),
                  const PopupMenuItem(
                    value: "Search",
                    child: Text("Search"),
                  ),
                  const PopupMenuItem(
                    value: "Mute notification",
                    child: Text("Mute notification"),
                  ),
                  const PopupMenuItem(
                    value: "Wallpaper",
                    child: Text("Wallpaper"),
                  ),
                  const PopupMenuItem(
                    value: "More",
                    child: Text("More"),
                  ),
                ];
              }),
            ],
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WillPopScope(
            onWillPop: () {
              if (showEmoji) {
                setState(() {
                  showEmoji = false;
                });
              } else {
                Navigator.pop(context);
              }
              return Future.value(false);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == messages.length) {
                        return Container(height: 30);
                      }
                      if (messages[index].type == "chatUser") {
                        return ChatMessageCard(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      } else {
                        return ReplyMessageCard(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 75,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 70,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                    left: 2,
                                    right: 2,
                                    bottom: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: TextFormField(
                                    controller: textController,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendChatButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendChatButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type your messages",
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                            icon: const Icon(Icons.attach_file),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.camera),
                                          ),
                                        ],
                                      ),
                                      contentPadding: const EdgeInsets.all(5),
                                      prefixIcon: IconButton(
                                        icon: Icon(showEmoji
                                            ? Icons.keyboard
                                            : Icons.emoji_emotions),
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            showEmoji = !showEmoji;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.tealAccent,
                                  child: IconButton(
                                    onPressed: () {
                                      if (sendChatButton) {
                                        scrollController.animateTo(
                                          scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 350),
                                          curve: Curves.easeOut,
                                        );
                                        sendChatMsg(
                                            textController.text,
                                            widget.chatUser.id,
                                            widget.chatsModel.id);
                                        textController.clear();
                                        setState(() {
                                          sendChatButton = false;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      sendChatButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          showEmoji ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomSheet() {
  return SizedBox(
    height: 270,
    width: 100,
    child: Card(
      margin: const EdgeInsets.all(17),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottomSheetIcons(
                  Icons.insert_drive_file,
                  Colors.blueAccent,
                  "Document",
                ),
                const SizedBox(
                  width: 35,
                ),
                bottomSheetIcons(
                  Icons.camera_alt,
                  Colors.deepPurpleAccent,
                  "Camera",
                ),
                const SizedBox(
                  width: 35,
                ),
                bottomSheetIcons(
                  Icons.insert_photo,
                  Colors.redAccent,
                  "Gallery",
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottomSheetIcons(
                  Icons.headset,
                  Colors.orangeAccent,
                  "Audio",
                ),
                const SizedBox(
                  width: 35,
                ),
                bottomSheetIcons(
                  Icons.location_pin,
                  Colors.tealAccent,
                  "Location",
                ),
                const SizedBox(
                  width: 35,
                ),
                bottomSheetIcons(
                  Icons.person,
                  Colors.amberAccent,
                  "Contact",
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget bottomSheetIcons(IconData icon, Color bgColor, String text) {
  return InkWell(
    onTap: () {},
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Icon(icon, size: 29, color: Colors.white),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(text, style: const TextStyle(fontSize: 12))
      ],
    ),
  );
}

Widget emojiSelect() {
  TextEditingController controller = TextEditingController();
  bool emojiShowing = false;

  return Offstage(
    offstage: emojiShowing,
    child: SizedBox(
      height: 120,
      child: EmojiPicker(
        textEditingController: controller,
        config: const Config(
          columns: 7,
          verticalSpacing: 0,
          horizontalSpacing: 0,
          skinToneDialogBgColor: Colors.white,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          replaceEmojiOnLimitExceed: false,
          tabIndicatorAnimDuration: Duration(milliseconds: 500),
        ),
        onEmojiSelected: (category, emoji) {
          // ignore: avoid_print
          print(emoji);
          controller.text = controller.text + emoji.emoji;
        },
      ),
    ),
  );
}
