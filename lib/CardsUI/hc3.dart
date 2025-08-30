import 'dart:developer';
import 'package:fam/models/build_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fam/models/card_data.dart';

class HC3 extends StatelessWidget {
  final CardData card;
  final RxBool isExpanded;
  final double containerWidth;

  const HC3({
    super.key,
    required this.card,
    required this.isExpanded,
    required this.containerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        image: card.bgImage != null
            ? DecorationImage(
          image: NetworkImage(card.bgImage!.imageUrl!),
          fit: BoxFit.fill,
          onError: (error, stackTrace) {
            log('Error loading background image: $error');
          },
        )
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, bottom: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 200),
              if (card.formattedTitle != null &&
                  card.formattedTitle!.entities.isNotEmpty) ...[
                SizedBox(
                  width: containerWidth - 48,
                  child: BuildFormattedText(
                    entity: card.formattedTitle!.entities[0],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'met_semi_bold',
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                SizedBox(
                  width: containerWidth - 48,
                  child: Text(
                    card.formattedTitle!.text.replaceAll(RegExp(r'[{}\n]'), ''),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'met_semi_bold',
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                if (card.formattedTitle!.entities.length > 1)
                  SizedBox(
                    width: containerWidth - 48,
                    child: BuildFormattedText(
                      entity: card.formattedTitle!.entities[1],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'met_regular',
                    ),
                  ),
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if (card.cta != null && card.cta!.isNotEmpty )
                ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(card.url!);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                    log('HC3 Card CTA: ${card.cta!.first.text}');
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    minimumSize: const Size(128, 42),
                  ),
                  child: Text(
                    card.cta!.first.text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
