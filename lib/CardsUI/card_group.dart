import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fam/models/card_data.dart';
import 'hc1.dart';
import 'hc3_animation.dart';
import 'hc5.dart';
import 'hc6.dart';
import 'hc9.dart';

class CardDesignFactory {
  static Widget createCardDesign(List<CardData> cards) {
    // Group cards by type
    Map<String, List<CardData>> cardGroups = {};
    for (var card in cards) {
      if (!cardGroups.containsKey(card.type)) {
        cardGroups[card.type] = [];
      }
      cardGroups[card.type]!.add(card);
    }

    List<Widget> cardWidgets = [];
    cardGroups.forEach((type, typeCards) {
      switch (type) {
        case 'HC9':
        // If more than one HC9 card, create a horizontal scroll view
          if (typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC9(
                card: card,
              ),
              height: 195,
            ));
          } else {
            cardWidgets.add(HC9(card: typeCards.first));
          }
          break;
        case 'HC3':
        // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => AnimatedHC3Card(card: card),
              height: 700, // Adjust height as needed
            ));
          } else {
            cardWidgets.add(AnimatedHC3Card(card: typeCards.first));
          }
          break;
        case 'HC1':
          if (typeCards.length > 1) {
            if (typeCards.first.isScrollable == false) {
              // When not scrollable and there are multiple cards, fit them in a row using Wrap
              cardWidgets.add(Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: typeCards.map((card) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = (constraints.maxWidth - 16) / 2;
                      return SizedBox(
                        width: cardWidth,
                        child: HC1(
                          card: card,
                          isInHorizontalScroll: false,
                        ),
                      );
                    },
                  );
                }).toList(),
              ));
            } else {
              // If scrollable, build a horizontal scroll view
              cardWidgets.add(_buildHorizontalCards(
                cards: typeCards,
                cardBuilder: (card) => HC1(
                  card: card,
                  isInHorizontalScroll: true,
                ),
                height: 90,
              ));
            }
          } else {
            // Single card case
            cardWidgets.add(HC1(
              card: typeCards.first,
              isInHorizontalScroll: false,
            ));
          }
          break;

        case 'HC5':
        // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC5(card: card),
              height: 200,
            ));
          } else {
            cardWidgets.add(HC5(card: typeCards.first));
          }
          break;
        case 'HC6':
        // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC6(card: card),
              height: 200,
            ));
          } else {
            cardWidgets.add(HC6(card: typeCards.first));
          }
          break;
        default:
          cardWidgets.add(Card(
            child: ListTile(
              title: Text('Unsupported Card Type: $type'),
            ),
          ));
      }
    });

    return ListView.separated(
      itemCount: cardWidgets.length,
      itemBuilder: (context, index) {
        return cardWidgets[index];
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10.0);
      },
    );
  }

  // Generic method to build horizontal scrollable cards
  static Widget _buildHorizontalCards({
    required List<CardData> cards,
    required Widget Function(CardData) cardBuilder,
    double? height,
  }) {
    return SizedBox(
      height: height ?? 200, // Default height if not provided
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: cardBuilder(cards[index]),
          );
        },
      ),
    );
  }
}

abstract class BaseCardDesign extends StatelessWidget {
  final CardData card;

  const BaseCardDesign({super.key, required this.card});
}