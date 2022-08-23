import 'package:flutter/material.dart';

class ReplyMessageCard extends StatelessWidget {
  final String message;
  final String time;

  const ReplyMessageCard({Key? key, required this.message, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 50,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 60,
                  top: 5,
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
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
