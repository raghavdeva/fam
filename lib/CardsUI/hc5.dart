import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fam/models/card_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HC5 extends StatelessWidget {
  final CardData card;

  const HC5({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(card.url!);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
        else {
          if (kDebugMode) {
            print("No URL provided");
          }
        }
      },
      child: Stack( // Using a Stack to overlay image and text
        children: [
          SizedBox(
            width: double.infinity, // Full width
            child: card.bgImage != null
                ? Image.network(
              card.bgImage!.imageUrl!,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to asset image when an error occurs
                return Image.asset(
                  'assets/icons/hc5fallback.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                );
              },
            )
                : Image.asset(
              'assets/icons/hc5fallback.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (card.title != null)
                    Text(
                      card.title!,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (card.description != null)
                    Text(
                      card.description!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  if (card.cta != null && card.cta!.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        // Implement CTA action
                        if (kDebugMode) {
                          print('HC5 Card CTA: ${card.cta!.first.text}');
                        }
                      },
                      child: Text(card.cta!.first.text),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}