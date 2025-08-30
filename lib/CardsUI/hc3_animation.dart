import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fam/models/card_data.dart';
import 'hc3.dart';

class AnimatedHC3Card extends StatefulWidget {
  final CardData card;

  const AnimatedHC3Card({Key? key, required this.card}) : super(key: key);

  @override
  State<AnimatedHC3Card> createState() => _AnimatedHC3CardState();
}

class _AnimatedHC3CardState extends State<AnimatedHC3Card> {
  final RxBool _isExpanded = false.obs;

  void _toggleCard() {
    _isExpanded.value = !_isExpanded.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _toggleCard,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Obx(() => Row(
          children: [
            // Button Section
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _isExpanded.value
                  ? MediaQuery.of(context).size.width * 0.35
                  : 0,
              height: _isExpanded.value
                  ? MediaQuery.of(context).size.height * 0.7
                  : 0,
              child: _buildButtons(),
            ),
            // Card Content Section
            Flexible(
              fit: FlexFit.tight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOut,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: _isExpanded.value
                          ? MediaQuery.of(context).size.width * 0.35
                          : MediaQuery.of(context).size.width,
                      height: _isExpanded.value
                          ? MediaQuery.of(context).size.height * 0.7
                          : MediaQuery.of(context).size.height * 0.6,
                      child: HC3(
                        card: widget.card,
                        isExpanded: _isExpanded,
                        containerWidth: constraints.maxWidth,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => log('Remind later clicked'),
          child: Container(
            height: 72,
            width: 89,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF7F6F3),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/bell.png',
                  height: 20,
                  width: 17,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Remind later',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => log('Dismiss now clicked'),
          child: Container(
            height: 72,
            width: 89,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF7F6F3),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/cross.png',
                  height: 20,
                  width: 17,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Dismiss now',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
