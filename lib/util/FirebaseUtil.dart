
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtil {
  static void changeMessageReadStatus(int messageId, bool status) {
    var firestore = FirebaseFirestore.instance;
    firestore.collection("message").doc(messageId.toString()).set({"read": status});
  }

  static Future<bool> getMessageReadStatus(int messageId) {
    var firestore = FirebaseFirestore.instance;
  }
}