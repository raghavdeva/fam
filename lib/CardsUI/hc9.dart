import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fam/models/card_data.dart';


class HC9 extends StatelessWidget {
  final CardData card;

  const HC9({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri _url = Uri.parse(card.url!);
        if (!await launchUrl(_url)) {
          throw Exception('Could not launch $_url');
        }
        else {
          print("No URL provided");
        }
      },
      child: SizedBox(
        height: 200,
        child: _buildCard(context),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    // Null check for background image
    if (card.bgImage?.imageUrl == null) {
      return Container(color: Colors.grey); // Fallback if no image
    }

    return AspectRatio(
      aspectRatio: card.bgImage?.aspectRatio ?? 1.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          gradient: card.bgGradient != null
              ? LinearGradient(
            colors: card.bgGradient!.colors.map((colorString) {
              return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
            }).toList(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          image: DecorationImage(
            image: NetworkImage(card.bgImage!.imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}