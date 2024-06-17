import 'package:cliplaza/components/message.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  static const route = 'chat';
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController searchController = TextEditingController();
  double height = 0;
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
                  child: Icon(Icons.keyboard_arrow_left_rounded)),
              CircleAvatar(),
              SizedBox(width: 9),
              Text(
                'Pizzium Milano',
                style: TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const Message(
                isSender: true,
                text:
                    'Buonasera, posso gentilmente chiedervi se nel vostro menu ci sono anche pizze senza glutine? Potrei vedere una foto di una pizza?'),
            const Message(
                isSender: false, text: 'Buonasera Susanna, certamente!'),
            Container(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/saahil-khatkhate-kfDsMDyX1K0-unsplash.webp',
                  width: 210,
                  height: 210,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Message(
                isSender: false,
                text:
                    'Questa è la nostra pizza senza glutine, ti mando subito il link per accedere al menu: http://drive.menu.pizzium'),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -81,
                child: AnimatedContainer(
                  margin: const EdgeInsets.only(left: 16),
                  width: 135,
                  height: height,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: height == 0
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                  ),
                  child: height == 0
                      ? Container()
                      : const Column(children: [
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.photo_camera_outlined,
                                  color: Color(0xFF515151),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Allega una foto',
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.videocam_outlined,
                                  color: Color(0xFF515151),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Allega un video',
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 13),
                                )
                              ],
                            ),
                          )
                        ]),
                ),
              ),
              Container(
                height: 38,
                margin: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 24, top: 18),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD1D1D1)),
                  color: Colors.white, // Grey background color
                  borderRadius: BorderRadius.circular(30), // Full border radius
                ),
                child: TextField(
                  onTap: () {
                    setState(() {
                      height = 0;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    hintText: 'Scrivi un messaggio',
                    border: InputBorder.none, // Remove default border
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            height == 0 ? height = 100 : height = 0;
                          });
                        },
                        icon: const Icon(Icons.attachment_outlined)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.send)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
