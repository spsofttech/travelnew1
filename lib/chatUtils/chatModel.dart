import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatModel {
  String sender;
  String senderName;
  String time;
  List seenBy;
  List chatGroup;
  List peopleInChat;
  String chatId;
  String message;
  String messageId;
  bool isGroup; //0- personal; 1 - group

  ChatModel(
      {required this.sender,
      required this.senderName,
      required this.time,
      required this.seenBy,
      required this.chatGroup,
      required this.peopleInChat,
      required this.isGroup,
      required this.chatId,
      required this.message,
      required this.messageId});

  sendChat(
      String sender,
      String senderName,
      String time,
      List<String> seenBy,
      List<String> chatGroup,
      List<String> peopleInChat,
      bool isGroup,
      String chatId,
      String message,
      String messageId) async {
    if (!isGroup) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('allChats')
          .doc(messageId)
          .set({
        'sender': sender,
        'senderName': senderName,
        'time': time,
        'seenBy': seenBy,
        'chatGroup': chatGroup,
        'peopleInChat': peopleInChat,
        'isGroup': isGroup,
        'chatId': chatId,
        'message': message,
        'messageId': messageId,
      });

      await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
        'sender': sender,
        'senderName': senderName,
        'time': time,
        'seenBy': seenBy,
        'chatGroup': chatGroup,
        'peopleInChat': peopleInChat,
        'isGroup': isGroup,
        'chatId': chatId,
        'message': message,
        'messageId': messageId,
      }, SetOptions(merge: true));
    } else {}
  }

  deleteMessage(
      String sender,
      String senderName,
      String time,
      List<String> seenBy,
      List<String> chatGroup,
      List<String> peopleInChat,
      bool isGroup,
      String chatId,
      String message,
      String messageId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('allChats')
        .doc(messageId)
        .delete();
  }

  clearChats(
      String sender,
      String senderName,
      String time,
      List<String> seenBy,
      List<String> chatGroup,
      List<String> peopleInChat,
      bool isGroup,
      String chatId,
      String message,
      String messageId) async {
    var x =
        await FirebaseFirestore.instance.collection('chats').doc(chatId).get();
    List abc = x.data()!['chatGroup'];
    abc.remove(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .set({'chatGroup': abc}, SetOptions(merge: true));
  }

  factory ChatModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ChatModel(
      sender: doc.data()!['sender'],
      senderName: doc.data()!['senderName'],
      time: doc.data()!['time'],
      seenBy: doc.data()!['seenBy'],
      chatGroup: doc.data()!['chatGroup'],
      peopleInChat: doc.data()!['peopleInChat'],
      isGroup: doc.data()!['isGroup'],
      chatId: doc.data()!['chatId'],
      message: doc.data()!['message'],
      messageId: doc.data()!['messageId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'senderName': senderName,
      'time': time,
      'seenBy': seenBy,
      'chatGroup': chatGroup,
      'isGroup': isGroup,
      'chatId': chatId,
      'message': message,
      'messageId': messageId,
    };
  }
}
