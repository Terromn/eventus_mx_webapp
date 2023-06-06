import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventus/assets/app_color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TeMap extends StatefulWidget {
  const TeMap({Key? key}) : super(key: key);

  @override
  State<TeMap> createState() => _TeMapState();
}

class _TeMapState extends State<TeMap> {
  final CollectionReference _referenceLocations =
      FirebaseFirestore.instance.collection('events');

  @override
  void initState() {
    super.initState();
  }

  Set<Marker> markers = {};

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(25.651685921530863, -100.36697532481787),
    zoom: 13.5,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _referenceLocations.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(TeAppColorPalette.purple),
          ));
        }

        final events = snapshot.data!.docs;

        // Clear the markers set to start fresh
        markers.clear();

        // Add a marker for each event in the database
        for (var event in events) {
          Marker currentMarker = Marker(
            markerId: MarkerId(event['eventName']),
            infoWindow: InfoWindow(title: event['eventName']),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: LatLng(
              event['locationCords'].latitude,
              event['locationCords'].longitude,
            ),
          );

          markers.add(currentMarker);
        }

        return GoogleMap(
          mapToolbarEnabled: false,
          markers: markers,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
        );
      },
    );
  }
}
