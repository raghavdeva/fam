import 'package:flutter/material.dart';
import 'package:fam/models/card_data.dart';
import 'card_group.dart';
import 'package:url_launcher/url_launcher.dart';

class HC1 extends BaseCardDesign {
  // Optional parameter to control width in horizontal scroll
  final bool isInHorizontalScroll;

  const HC1({
    Key? key,
    required CardData card,
    required this.isInHorizontalScroll,
  }) : super(key: key, card: card);

  @override
  Widget build(BuildContext context) {
    // Get screen width from MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: isInHorizontalScroll ? 250 : screenWidth * 0.9, // Adjust width for horizontal scroll or 90% of screen width
      height: card.height,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () async {
          final Uri _url = Uri.parse(card.url!);
          if (!await launchUrl(_url)) {
            throw Exception('Could not launch $_url');
          }
          else {
            print("No URL provided");
          }
        },
        child: Card(
          elevation: 0,
          color: Color(int.parse(card.bgColor!.replaceFirst('#', '0xFF'))),
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ListTile
              ListTile(
                leading: _buildLeadingIcon(),
                title: _buildTitle(context),
                subtitle: _buildSubtitle(context),
                trailing: _buildTrailingCTA(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildLeadingIcon() {
    return card.icon?.imageUrl != null
        ? Image.network(
      card.icon!.imageUrl!,
      width: 35,
      height: 35,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/icons/hc1fallback.png', // Fallback image from assets
          width: 35,
          height: 35,
          fit: BoxFit.cover,
        );
      },
    )
        : null;
  }

  Widget _buildTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 600 ? 18 : 14;

    if (card.formattedTitle != null) {
      if (card.formattedTitle!.entities.isNotEmpty) {
        return Text(
          card.formattedTitle!.entities.first.text,
          style: TextStyle(
            color: card.formattedTitle!.entities.first.color != null
                ? Color(int.parse(card.formattedTitle!.entities.first.color!.replaceFirst('#', '0xFF')))
                : null,
            fontStyle: card.formattedTitle!.entities.first.fontStyle == 'italic'
                ? FontStyle.italic
                : FontStyle.normal,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      return Text(
        card.formattedTitle!.text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
      );
    }

    return Text(
      card.title ?? card.name,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
    );
  }

  Widget? _buildSubtitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 600 ? 16 : 14; // Slightly larger subtitle for bigger screens

    if (card.formattedDescription != null) {
      if (card.formattedDescription!.entities.isNotEmpty) {
        return Text(
          card.formattedDescription!.entities.first.text,
          style: TextStyle(
            color: card.formattedDescription!.entities.first.color != null
                ? Color(int.parse(card.formattedDescription!.entities.first.color!.replaceFirst('#', '0xFF')))
                : null,
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),
        );
      }
      // Fallback to formatted description text
      return Text(
        card.formattedDescription!.text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
      );
    }

    return card.description != null
        ? Text(
      card.description!,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
    )
        : null;
  }

  Widget? _buildTrailingCTA() {
    // Check if CTAs exist
    if (card.cta != null && card.cta!.isNotEmpty) {
      final firstCTA = card.cta!.first;
      return ElevatedButton(
        onPressed: () {
          print('HC1 Card CTA: ${firstCTA.text}');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: firstCTA.bgColor != null
              ? Color(int.parse(firstCTA.bgColor!.replaceFirst('#', '0xFF')))
              : null,
        ),
        child: Text(
          firstCTA.text,
          style: TextStyle(
            color: firstCTA.textColor != null
                ? Color(int.parse(firstCTA.textColor!.replaceFirst('#', '0xFF')))
                : null,
          ),
        ),
      );
    }
    return null;
  }
}
