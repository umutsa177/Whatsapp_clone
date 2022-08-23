import 'package:flutter/material.dart';

class ChatMessageCard extends StatelessWidget {
  final String message;
  final String time;

  const ChatMessageCard({Key? key, required this.message, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 70,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.cyan[200],
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 60,
                  top: 10,
                  bottom: 20,
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.done_all,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
