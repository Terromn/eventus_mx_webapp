import 'package:eventus/assets/app_color_palette.dart';
import 'package:eventus/screens/event_info_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final NetworkImage eventPhoto;
  final String id;
  final String eventName;
  final String locationName;
  final int coverPrice;
  final Uri instaLink;
  final Uri whatsLink;
  final String description;
  final Timestamp date;

  final storageRef = FirebaseStorage.instance.ref();

  EventCard({
    super.key,
    required this.eventPhoto,
    required this.eventName,
    required this.locationName,
    required this.date,
    required this.coverPrice,
    required this.instaLink,
    required this.whatsLink,
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 18, left: 8, right: 8),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: TeAppColorPalette.pink,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
            BoxShadow(
              color: TeAppColorPalette.purple,
              offset: Offset(-1, -1),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            colors: [
              TeAppColorPalette.purple,
              TeAppColorPalette.pink,
            ],
          ),
        ),
        child: Card(
          color: TeAppColorPalette.black,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: eventPhoto,
              radius: 24,
              backgroundColor: TeAppColorPalette.purple,
            ),
            title: Text(
              "$eventName - \$$coverPrice",
              style: GoogleFonts.mPlusRounded1c(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: const Icon(Icons.location_on, size: 12),
                    ),
                    Text(
                      locationName,
                      style: GoogleFonts.mPlusRounded1c(
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: const Icon(Icons.date_range, size: 12),
                    ),
                    Text(
                        DateFormat('MMM dd, yyyy')
                            .format(date.toDate())
                            .toString(),
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                  ],
                )
              ],
            ),
            trailing: IconButton(
              iconSize: 38,
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventInfoScreen(
              id: id,
              eventName: eventName,
              coverPrice: coverPrice,
              instaLink: instaLink,
              whatsLink: whatsLink,
              date: date,
              locationCords: const GeoPoint(0, 0),
              locationName: locationName,
              description: description,
              eventPhoto: eventPhoto,
            ),
          ),
        );
      },
    );
  }
}
