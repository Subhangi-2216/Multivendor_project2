import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your shopping cart is empty',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 188, 142),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
