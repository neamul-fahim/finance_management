import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: screenSize.height * 0.3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    color: Colors.brown),
              ),
              Positioned(
                top: screenSize.height * 0.2,
                left: 20,
                right: 20,
                child: Container(
                  height: screenSize.height * 0.2,
                  width: screenSize.width,
                  decoration: BoxDecoration(color: Colors.brown.shade400),
                ),
              )
            ],
          ),
          Text("hello"),
        ],
      ),
    );
  }
}