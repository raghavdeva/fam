import 'package:fam/services/card_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fam/services/card_group_controller.dart';
import '../CardsUI/card_group.dart';


class CardScreen extends StatelessWidget {
  final CardGroupController _cardController = Get.put(CardGroupController());

  CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F3),
      body: Obx(
            () {
          // Loading state
          if (_cardController.isLoadingCards.value) {
            return const Center(child: CircularProgressIndicator());
          }
          // Error state
          if (_cardController.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${_cardController.errorMessage.value}'),
                  ElevatedButton(
                    onPressed: _cardController.loadCardGroups,
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }
          // No cards state
          if (_cardController.cardList.isEmpty) {
            return const Center(
              child: Text('No cards available'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Trigger the API call when pulled
              await _cardController.loadCardGroups();
            },
            child: CardDesignFactory.createCardDesign(_cardController.cardList),
          );
        },
      ),
    );
  }
}
