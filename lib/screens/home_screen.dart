import 'package:eventus/assets/app_color_palette.dart';
import 'package:eventus/utlis/get_info_helper.dart';
import 'package:eventus/utlis/ui_enhancer_helper.dart';
import 'package:eventus/widgets/te_container.dart';
import 'package:eventus/widgets/te_map.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/te_event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _referenceEvents =
      FirebaseFirestore.instance.collection('events');
  final _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();

    _streamEvents = _referenceEvents.snapshots();
    _storageRef = _storage.ref().child('/eventLogos');
  }

  late Stream<QuerySnapshot> _streamEvents;
  late Reference _storageRef;

  late String eventPhotoLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TeAppColorPalette.black,
      child: Column(
        children: [
          ///////////////////
          // TOP CONTAINER //
          ///////////////////
          TeContainer(
            height: TeInformationUtil.getPercentageHeight(context, 30),
            topLeft: 0,
            topRight: 0,
            bottomLeft: 40,
            bottomRight: 40,
            child: const TeMap(),
          ),

          TeEnhancerUtil.verticalSpacing(40),

          //////////////////////
          // BOTTOM CONTAINER //
          //////////////////////
          Expanded(
            child: TeContainer(
              height: TeInformationUtil.getPercentageHeight(context, 40),
              topLeft: 40,
              topRight: 40,
              bottomLeft: 0,
              bottomRight: 0,
              child: StreamBuilder<QuerySnapshot>(
                stream: _streamEvents,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          TeAppColorPalette.purple),
                    ));
                  }

                  final events = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = events[index];
                      return FutureBuilder<String>(
                        future: _storageRef
                            .child('${event['id']}.png')
                            .getDownloadURL(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    TeAppColorPalette.purple),
                              ),
                            );
                          }

                          final url = snapshot.data!.toString();

                          return EventCard(
                            id: event['id'],
                            eventPhoto: NetworkImage(url),
                            eventName: event['eventName'],
                            locationName: event['locationName'],
                            date: event['date'],
                            coverPrice: event['coverPrice'],
                            description: event['description'],
                            instaLink: Uri.parse(event['instaLink']),
                            whatsLink: Uri.parse(event['whatsLink']),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
