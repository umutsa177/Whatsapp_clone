import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/StatusPage/newStatusCard.dart';
import 'package:whatsapp_clone/CustomUI/StatusPage/orderStatus.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(
                Icons.edit,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.purpleAccent[900],
            elevation: 5,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(),
            const NewStatusCard(),
            label("Recent Updates"),
            const OtherStatus(
              name: "Hello EveryOne",
              image: "",
              time: "12:00",
              viewedStatus: false,
              statusCount: 3,
            ),
            const OtherStatus(
              name: "What's going today?",
              image: "",
              time: "12:00",
              viewedStatus: false,
              statusCount: 9,
            ),
            const OtherStatus(
              name: "Hi!",
              image: "",
              time: "12:00",
              viewedStatus: false,
              statusCount: 4,
            ),
            const OtherStatus(
              name: "I'm so beautiful",
              image: "",
              time: "12:00",
              viewedStatus: false,
              statusCount: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            label("Viewed updates"),
            const OtherStatus(
              name: "How is it going today?",
              image: "",
              time: "12:00",
              viewedStatus: true,
              statusCount: 11,
            ),
            const OtherStatus(
              name: "I like to moved it :)",
              image: "",
              time: "12:00",
              viewedStatus: true,
              statusCount: 4,
            ),
            const OtherStatus(
              name: "Never give up, miracles happen everyday",
              image: "",
              time: "12:00",
              viewedStatus: true,
              statusCount: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String text) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
