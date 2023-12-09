import 'package:chatapp/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  Future<void> sendMessage(String reciverId, String message) async {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final String currentUserEmail =
        FirebaseAuth.instance.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        reciverId: reciverId,
        message: message,
        timestamp: timestamp);
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
