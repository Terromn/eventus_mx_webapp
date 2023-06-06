import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventus/assets/app_color_palette.dart';
import 'package:eventus/screens/auth/auth.dart';
import 'package:eventus/utlis/stripe/stripe_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  final CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final _storage = FirebaseStorage.instance;
  late DocumentReference userDocument;
  late DocumentSnapshot userFields;
  late Reference _storageRef;

  Future<void> _singOut() async {
    await Auth().signOut();
  }

  Widget _userName(DocumentSnapshot userFields) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        userFields['name'],
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _profilePicture(DocumentSnapshot userFields, Reference reference) {
    return FutureBuilder<String>(
      future: reference.child(userFields['profilePicture']).getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(TeAppColorPalette.purple),
          );
        } else if (snapshot.hasError) {
          return const Text('Error loading profile picture');
        } else {
          final imageUrl = snapshot.data;
          return Container(
            margin: const EdgeInsets.only(top: 32),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl!),
              radius: 110,
            ),
          );
        }
      },
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: _singOut,
      child: const Text('Sign Out'),
    );
  }

  Widget _qrCodeListItem(String paymentIntentID) {
    return FutureBuilder<String?>(
      future:
          getProductName(paymentIntentID), // Call getProductName as a Future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(TeAppColorPalette.purple),
          );
        } else if (snapshot.hasError) {
          return const Text('Error loading product name');
        } else {
          final productName = snapshot.data;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QrImage(
                    data: paymentIntentID,
                    size: 220,
                    backgroundColor: TeAppColorPalette.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(productName ?? 'Tenzorial Ticket',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    userDocument =
        FirebaseFirestore.instance.collection('users').doc(user?.uid);

    _storageRef = _storage.ref().child('/defaultProfilePictures');

    return FutureBuilder<DocumentSnapshot>(
      future: userDocument.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            DocumentSnapshot userFields = snapshot.data!;
            List<dynamic> qrCodes = userFields['qrCodes'];
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _profilePicture(userFields, _storageRef),
                  _userName(userFields),
                  _signOutButton(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.builder(
                        itemCount: qrCodes.length,
                        itemBuilder: (context, index) {
                          return _qrCodeListItem(qrCodes[index]);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 60)
                ],
              ),
            );
          } else {
            return const Text('No Tickets Available');
          }
        }
      },
    );
  }
}
