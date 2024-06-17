import 'package:cliplaza/components/button.dart';
import 'package:cliplaza/pages/checkout.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});
  static const route = 'cart';
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  void removeItem(List list, int index) {
    setState(() {
      list.removeAt(index);
      userState.refresh();
    });
  }

  void addOrRemoveToCart(Map<String, dynamic> item, bool isLaterCart) {
    setState(() {
      if (isLaterCart) {
        userState.value.laterCartItems.remove(item);
        userState.value.cartItems.add(item);
      } else {
        userState.value.cartItems.remove(item);
        userState.value.laterCartItems.add(item);
      }
      userState.refresh();
    });
  }

  double calculateTotalPrice() {
    double total = 0.0;

    for (var item in userState.value.cartItems) {
      double price = double.parse(item['price'].replaceAll(',', '.'));
      int quantity = item['quantity'];

      total += price * quantity;
    }

    return total;
  }

  void updateQuantity(Map<String, dynamic> product, int newQuantity) {
    setState(() {
      product['quantity'] = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Il mio carrello',
              style: TextStyle(
                  color: Color(0xFF0C0C0C), fontFamily: 'bold', fontSize: 16),
            ),
            floating: true,
            snap: true,
          ),
          SliverList.builder(
            itemCount: userState.value.cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              final product = userState.value.cartItems[index];

              return SwipeLimitWidget(
                onQuantityChanged: (newQuantity) =>
                    updateQuantity(product, newQuantity),
                key: ValueKey(product),
                delete: () => removeItem(userState.value.cartItems, index),
                onTap: () => addOrRemoveToCart(product, false),
                product: product,
                isLaterCart: false,
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Text(
                    'Totale',
                    style: TextStyle(color: Color(0xFF747474), fontSize: 17),
                  ),
                  const Spacer(),
                  Text(
                    '${calculateTotalPrice().toStringAsFixed(2)}€',
                    style: const TextStyle(
                        color: Color(0xFF0C0C0C),
                        fontSize: 17,
                        fontFamily: 'bold'),
                  ),
                  const SizedBox(width: 16)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
            child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                  const TextSpan(
                    text: 'Salvati per dopo ',
                    style: TextStyle(
                        color: Color(0xFF0C0C0C),
                        fontFamily: 'bold',
                        fontSize: 17),
                  ),
                  TextSpan(
                    text: '(${userState.value.laterCartItems.length} articoli)',
                    style:
                        const TextStyle(color: Color(0xFF747474), fontSize: 15),
                  )
                ])),
          )),
          SliverList.builder(
            itemCount: userState.value.laterCartItems.length,
            itemBuilder: (BuildContext context, int index) {
              final product = userState.value.laterCartItems[index];

              return SwipeLimitWidget(
                onQuantityChanged: (newQuantity) =>
                    updateQuantity(product, newQuantity),
                key: ValueKey(product),
                delete: () => removeItem(userState.value.laterCartItems, index),
                onTap: () => addOrRemoveToCart(product, true),
                product: product,
                isLaterCart: true,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.only(bottom: 27, left: 16, right: 16, top: 20),
            child: CustomButton(
                paddingY: 12,
                onPressed: userState.value.cartItems.isEmpty
                    ? null
                    : () => Navigator.pushNamed(context, CheckoutPage.route),
                center: Text(
                  userState.value.cartItems.isEmpty
                      ? 'Nessun elemento nel carrello'
                      : 'Procedi al checkout : ${calculateTotalPrice().toStringAsFixed(2)}€',
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'semibold',
                      color: Colors.white),
                ),
                bg: const Color(0xFF7A5DCB)),
          ),
        ],
      ),
    );
  }
}

class SwipeLimitWidget extends StatefulWidget {
  const SwipeLimitWidget(
      {super.key,
      required this.delete,
      required this.onTap,
      required this.product,
      required this.isLaterCart,
      required this.onQuantityChanged});

  final void Function()? onTap;
  final void Function()? delete;
  final Map<String, dynamic> product;
  final bool isLaterCart;
  final void Function(int newQuantity) onQuantityChanged;

  @override
  State<SwipeLimitWidget> createState() => _SwipeLimitWidgetState();
}

class _SwipeLimitWidgetState extends State<SwipeLimitWidget> {
  double _dragExtent = 0.0;
  final double _maxDragDistance = -40.0; // Negative for left swipe

  void _updateDragExtent(DragUpdateDetails details) {
    setState(() {
      _dragExtent += details.delta.dx;
      _dragExtent = _dragExtent.clamp(
          _maxDragDistance, 0.0); // Allow moving back to start
    });
  }

  @override
  void didUpdateWidget(SwipeLimitWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.product != oldWidget.product) {
      _resetDragState();
    }
  }

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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFD1D1D1),
                        width: .6,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product['company'],
                          style: const TextStyle(
                              color: Color(0xFF8B8B8B), fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/${widget.product['image']}',
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 10),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product['name'],
                                    style: const TextStyle(
                                        color: Color(0xFF0C0C0C),
                                        fontFamily: 'semibold',
                                        fontSize: 15),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    widget.product['subtitle'] ?? '',
                                    style: const TextStyle(
                                        color: Color(0xFF747474), fontSize: 13),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    widget.product['price'],
                                    style: const TextStyle(
                                        color: Color(0xFF0C0C0C),
                                        fontFamily: 'semibold',
                                        fontSize: 15),
                                  ),
                                ]),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFE8E8E8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  GrayContainer(
                                    onTap: () {
                                      setState(() {
                                        if (widget.product['quantity'] == 1) {
                                          return;
                                        }
                                        widget.product['quantity']--;
                                        widget.onQuantityChanged(
                                            widget.product['quantity']);
                                      });
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    '${widget.product['quantity']}',
                                    style: const TextStyle(
                                        color: Color(0xFF171717),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 20),
                                  GrayContainer(
                                    onTap: () {
                                      setState(() {
                                        widget.product['quantity']++;
                                        widget.onQuantityChanged(
                                            widget.product['quantity']);
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: widget.onTap,
                          child: Text(
                            widget.isLaterCart
                                ? 'Aggiungi al carrello'
                                : 'Salva per dopo',
                            style: const TextStyle(
                                color: Color(0xFFE3B957),
                                fontFamily: 'semibold',
                                fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 8)
                      ])),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 30,
          top: 10,
          child: AnimatedContainer(
            margin: const EdgeInsets.only(right: 12),
            duration: const Duration(milliseconds: 50),
            width: containerWidth, // Ensure non-negative width
            height: 130,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFAE9E7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: InkWell(
              onTap: widget.delete,
              child: SvgPicture.asset('assets/images/icona elimina.svg'),
            ),
          ),
        ),
      ],
    );
  }
}

class GrayContainer extends StatelessWidget {
  const GrayContainer({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  final void Function() onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: icon,
      ),
    );
  }
}
