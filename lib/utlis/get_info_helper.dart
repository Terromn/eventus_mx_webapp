import 'package:flutter/cupertino.dart';

class TeInformationUtil {
  static double getPercentageHeight(BuildContext context, double percentage) {
    double screenHeight = MediaQuery.of(context).size.height;
    return (percentage / 100.0) * screenHeight;
  }

  static double getPercentageWidth(BuildContext context, double percentage) {
    double screenWidth = MediaQuery.of(context).size.height;
    return (percentage / 100.0) * screenWidth;
  }

// static Future<String?> getLocationName(GeoPoint latLng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
//       Placemark place = placemarks[0];
//       String address = "${place.name}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
//       return address;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
}
