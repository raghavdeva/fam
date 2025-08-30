import 'dart:convert';
import 'api.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fam/models/card_data.dart';

class CardGroupController extends GetxController {
  final RxList<CardData> cardList = <CardData>[].obs;
  final RxBool isLoadingCards = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> loadCardGroups() async {
    isLoadingCards.value = true;
    errorMessage.value = '';
    const apiUrl = Api.cardGroupsUrl;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<CardData> loadedCards = [];

        for (final group in responseData) {
          final List<dynamic> cardGroups = group['hc_groups'] as List<dynamic>;

          for (final cardGroup in cardGroups) {
            final String designType = cardGroup['design_type'] ?? 'Unknown';
            final List<dynamic> cardsData = cardGroup['cards'];

            loadedCards.addAll(cardsData.map((cardJson) {
              final Map<String, dynamic> cardWithDesignType =
              Map<String, dynamic>.from(cardJson);
              cardWithDesignType['design_type'] = designType;

              return CardData.fromJson(cardWithDesignType);
            }));
          }
        }

        cardList.assignAll(loadedCards);

        if (kDebugMode) {
          for (var card in loadedCards) {
            print('Parsed Card: ${card.type}, Name: ${card.name}');
          }
        }
      } else {
        errorMessage.value = 'Failed to fetch cards: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching cards: $e';
    } finally {
      isLoadingCards.value = false;
    }
  }
}
