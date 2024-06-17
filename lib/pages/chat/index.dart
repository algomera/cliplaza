import 'package:cliplaza/pages/chat/show.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});
  static const route = 'chats';
  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 38,
          margin:
              const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3), // Grey background color
            borderRadius: BorderRadius.circular(30), // Full border radius
          ),
          child: const TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Padding for text input
              hintText: 'Cerca', // Placeholder text
              border: InputBorder.none, // Remove default border
              prefixIcon: Icon(Icons.search), // Suffix icon
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 16),
            const Text(
              'Messaggi',
              style: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          const SizedBox(height: 40),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Row(children: [
                              Icon(Icons.keyboard_arrow_left_rounded),
                              Text(
                                'Indietro',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF171717)),
                              )
                            ]),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Scrivi un messaggio a:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF171717)),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 38,
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFF3F3F3), // Grey background color
                              borderRadius: BorderRadius.circular(
                                  30), // Full border radius
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10), // Padding for text input
                                hintText: 'Cerca', // Placeholder text
                                border:
                                    InputBorder.none, // Remove default border
                                prefixIcon: Icon(Icons.search), // Suffix icon
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset('assets/images/icona messaggi.svg'),
                  Positioned(
                    bottom: -2,
                    right: -4,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFA13BA7),
                        border: Border.all(color: Colors.white, width: 1.8),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, color: Colors.white, size: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16)
          ],
        ),
        Expanded(
          child: CustomScrollView(slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                return ChatTile(
                    delete: () {
                      setState(() {
                        userState.value.chats.removeAt(index);
                      });
                    },
                    userName: userState.value.chats[index]['name']);
              },
              itemCount: userState.value.chats.length,
            )
          ]),
        )
      ],
    ));
  }
}

class ChatTile extends StatefulWidget {
  const ChatTile({super.key, required this.delete, required this.userName});
  final void Function()? delete;
  final String userName;
  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  double _dragExtent = 0.0;
  final double _maxDragDistance = -40.0; // Negative for left swipe

  void _updateDragExtent(DragUpdateDetails details) {
    setState(() {
      _dragExtent += details.delta.dx;
      _dragExtent = _dragExtent.clamp(
          _maxDragDistance, 0.0); // Allow moving back to start
    });
  }

  // @override
  // void didUpdateWidget(SwipeLimitWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.product != oldWidget.product) {
  //     _resetDragState();
  //   }
  // }

  void _resetDragState() {
    setState(() {
      _dragExtent = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = (_dragExtent / _maxDragDistance) * 30.0;
    containerWidth =
        containerWidth.clamp(0.0, 30.0); // Ensure width is always non-negative

    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: _updateDragExtent,
          child: Transform.translate(
            offset: Offset(_dragExtent, 0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Chat.route);
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: .6),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const CircleAvatar(),
                          const SizedBox(width: 9),
                          Text(widget.userName)
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed…',
                        style: TextStyle(color: Color(0xFF0C0C0C)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16)
                    ],
                  )),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          top: 10,
          right: 0,
          child: InkWell(
            onTap: widget.delete,
            child: AnimatedContainer(
              margin: const EdgeInsets.only(right: 12),
              duration: const Duration(milliseconds: 50),
              width: containerWidth, // Ensure non-negative width

              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFAE9E7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SvgPicture.asset('assets/images/icona elimina.svg'),
            ),
          ),
        ),
      ],
    );
  }
}
