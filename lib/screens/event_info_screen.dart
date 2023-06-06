// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventus/assets/app_color_palette.dart';
import 'package:eventus/assets/themes/app_theme.dart';
import 'package:eventus/widgets/te_buy_button.dart';
import 'package:eventus/widgets/te_map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utlis/stripe/stripe_checkout.dart';
import '../utlis/get_info_helper.dart';

class EventInfoScreen extends StatelessWidget {
  final String id;
  final String eventName;
  final int coverPrice;
  final Uri instaLink;
  final Uri whatsLink;
  final Timestamp date;
  final GeoPoint locationCords;
  final String locationName;
  final String description;
  final NetworkImage eventPhoto;

  const EventInfoScreen({
    super.key,
    required this.eventName,
    required this.coverPrice,
    required this.instaLink,
    required this.whatsLink,
    required this.date,
    required this.locationCords,
    required this.locationName,
    required this.description,
    required this.id,
    required this.eventPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventName.toUpperCase()),
        toolbarHeight: TeInformationUtil.getPercentageHeight(context, 8),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Center(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: TeAppColorPalette.pink,
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: TeAppThemeData.teShadow,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: eventPhoto,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TeBuyButton(
                  color1: TeAppColorPalette.whatsApp1,
                  color2: TeAppColorPalette.whatsApp2,
                  height: 60,
                  width: 60,
                  icon: const Icon(Icons.wechat_sharp, size: 18),
                  text: 'null',
                  url: whatsLink,
                ),
                TeBuyButton(
                  color1: TeAppColorPalette.insta1,
                  color2: TeAppColorPalette.insta2,
                  height: 60,
                  width: 60,
                  icon: const Icon(Icons.camera_alt_rounded, size: 18),
                  text: 'null',
                  url: instaLink,
                ),
                TeBuyButton(
                  color1: TeAppColorPalette.purple,
                  color2: TeAppColorPalette.pink,
                  height: 60,
                  width: 60,
                  icon: const Icon(Icons.share_rounded, size: 18),
                  text: 'null',
                  url: whatsLink, // TOOD SHARE
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'DESCRIPTION',
                    style: TeAppThemeData.darkTheme.textTheme.displayLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(28)),
                      child: SizedBox(
                        width: double.infinity,
                        height:
                            TeInformationUtil.getPercentageHeight(context, 20),
                        child: const TeMap(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          TeAppColorPalette.pink,
                          TeAppColorPalette.purple
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: Text(
                        locationName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          TeAppColorPalette.purple,
                          TeAppColorPalette.pink
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: Text(
                        DateFormat.yMMMd().format(date.toDate()).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(description),
                  ),
                  Container(
                    height: 44,
                    margin: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 12),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TeAppColorPalette.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          // User is logged in, proceed with checkout
                          redirectToCheckout(context, id, eventName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please log in to proceed...'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'BUY - \$$coverPrice',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
