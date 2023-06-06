import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadSessionId(String sessionId) async {
  final firestore = FirebaseFirestore.instance;
  final collectionRef = firestore.collection('sessions');

  try {
    await collectionRef.add({
      'sessionId': sessionId.toString(),
      'timestamp': DateTime.now(),
    });
  } catch (error) {
    // ignore: avoid_print
    print('Error uploading sessionId: $error');
  }
}
