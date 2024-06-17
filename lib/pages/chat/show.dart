import 'package:cliplaza/components/message.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  static const route = 'chat';
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  double height = 0;
  final List<MessageData> messages = [
    MessageData(
      isSender: true,
      text:
          'Buonasera, posso gentilmente chiedervi se nel vostro menu ci sono anche pizze senza glutine? Potrei vedere una foto di una pizza?',
    ),
    MessageData(
      isSender: false,
      text: 'Buonasera Susanna, certamente!',
    ),
    MessageData(
      isSender: false,
      isImage: true,
      imageUrl: 'assets/images/saahil-khatkhate-kfDsMDyX1K0-unsplash.webp',
    ),
    MessageData(
      isSender: false,
      text:
          'Questa è la nostra pizza senza glutine, ti mando subito il link per accedere al menu: http://drive.menu.pizzium',
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void sendMessage() {
    String text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(MessageData(isSender: true, text: text));
        _textController.clear();
      });

      // Scroll dopo l'invio del messaggio
      Future.delayed(const Duration(milliseconds: 50), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void sendImage() {
    setState(() {
      messages.add(MessageData(
        isSender: true,
        isImage: true,
        imageUrl: 'assets/images/saahil-khatkhate-kfDsMDyX1K0-unsplash.webp',
      ));
    });

    // Scroll dopo l'invio dell'immagine
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  bool showOptions = true;
  void toggleOptions() {
    setState(() {
      showOptions = !showOptions;
    });
  }

  void hideOptions() {
    setState(() {
      showOptions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.keyboard_arrow_left_rounded)),
            const CircleAvatar(),
            const SizedBox(width: 9),
            const Text(
              'Pizzium Milano',
              style: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final message = messages[index];
                  if (message.isImage) {
                    return Message(
                      isImage: message.isImage,
                      imageUrl: message.imageUrl,
                      isSender: message.isSender,
                      text: message.text,
                    );
                  }
                  return Message(
                      isSender: message.isSender, text: message.text);
                },
                childCount: messages.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TextField(
        controller: _textController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: 'Scrivi un messaggio',
          border: InputBorder.none, // Remove default border
          suffixIcon: IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
          ),
          prefixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.attachment_outlined),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: sendImage,
                value: 'Allega foto',
                child: const Row(
                  children: [
                    Icon(Icons.attach_file),
                    SizedBox(width: 8),
                    Text('Allega foto'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Allega video',
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 8),
                    Text('Allega video'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              // Handle option selection
              print('Selected: $value');
            },
          ),
        ),
      ),
    );
  }
}
