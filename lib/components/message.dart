import 'package:flutter/material.dart';

class MessageData {
  final bool isSender;
  final String text;
  final bool isImage;
  final String? imageUrl;

  MessageData({
    required this.isSender,
    this.text = '',
    this.isImage = false,
    this.imageUrl,
  });
}

class Message extends StatelessWidget {
  const Message(
      {super.key,
      required this.isSender,
      required this.text,
      this.imageUrl,
      this.isImage});
  final bool isSender;
  final String text;
  final bool? isImage;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          constraints: BoxConstraints(
              minHeight: isImage == true ? 254 : 0,
              minWidth: isImage == true ? 254 : 0,
              maxWidth: 254),
          padding: const EdgeInsets.all(14),
          decoration: ShapeDecoration(
            image: isImage != null
                ? DecorationImage(
                    image: AssetImage(imageUrl!), fit: BoxFit.cover)
                : null,
            color: isSender ? const Color(0xFFF4E3F5) : const Color(0xFFF3F3F3),
            shape: RoundedRectangleBorder(
              borderRadius: isSender
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF1E1F30),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
