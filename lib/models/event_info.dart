import 'package:cloud_firestore/cloud_firestore.dart';

class EventInfo {
  final String id;
  final String eventName;
  final int coverPrice;
  final String instaLink;
  final String whatsLink;
  final DateTime date;
  final GeoPoint locationCords;
  final String locationName;
  final String description;

  EventInfo({
    required this.id,
    required this.eventName,
    required this.coverPrice,
    required this.instaLink,
    required this.whatsLink,
    required this.date,
    required this.locationCords,
    required this.locationName,
    required this.description,
  });
}
