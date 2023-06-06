import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventus/assets/app_color_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final String paymentSessionId;
  final String eventName;

  const SuccessScreen({Key? key, required this.paymentSessionId, required this.eventName})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    addPaymentSessionToFirestore();
  }

  Future<void> addPaymentSessionToFirestore() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final paymentSession = widget.paymentSessionId;
    final eventName = widget.eventName;

    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'qrCodes': FieldValue.arrayUnion(['${eventName}_$paymentSession'])
      });
      // ignore: avoid_print
      print('Payment session added to Firestore');
    } catch (error) {
      // ignore: avoid_print
      print('Error adding payment session to Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(TeAppColorPalette.purple),
            ),
            SizedBox(height: 20.0),
            Text('Saving QrCode to Your Profile'),
          ],
        ),
      ),
    );
  }
}
