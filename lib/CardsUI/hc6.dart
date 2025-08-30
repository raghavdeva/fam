import 'dart:developer';
import 'package:fam/models/formatted_text.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import 'package:fam/models/card_data.dart';

class HC6 extends StatelessWidget {
  final CardData card;
  final bool isScrollable;

  const HC6({
    super.key,
    required this.card,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return isScrollable
        ? SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [_buildCard(context, card)],
      ),
    )
        : Column(
      children: [_buildCard(context, card)],
    );
  }

  Widget _buildCard(BuildContext context, CardData card) {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(card.url!);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        } else {
          if (kDebugMode) {
            print("No URL provided");
          }
        }
      },
      child: Card(
        elevation: 0,
        color: Color(int.parse(card.bgColor!.replaceFirst('#', '0xFF'))),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: _buildBackgroundDecoration(card),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading Icon
              Row(
                children: [
                  card.bgImage != null
                      ? Image.network(
                    card.bgImage!.imageUrl!,
                    width: 30,
                    height: 30,
                  )
                      : Image.asset(
                    'assets/images/hc6fallback.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (card.formattedTitle != null &&
                      card.formattedTitle!.entities.isNotEmpty)
                    BuildFormattedText(
                      entity: card.formattedTitle!.entities[0],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'met_semi_bold',
                    ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration? _buildBackgroundDecoration(CardData card) {
    if (card.bgGradient != null) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: List<Color>.from(
            card.bgGradient!.colors.map(
                  (color) => Color(int.parse(color.replaceFirst('#', '0xFF'))),
            ),
          ),
        ),
      );
    } else if (card.bgImage != null) {
      return BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(card.bgImage!.imageUrl ?? ''),
          fit: BoxFit.cover,
        ),
      );
    }
    return null;
  }
}
