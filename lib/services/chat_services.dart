import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../models/chat.dart';
import '../../models/message.dart';
import '../../models/participants.dart';
import '../core/helpers/chat_helpers.dart';

class ChatServices{

  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final Logger _logger = Logger();

  static final CollectionReference _chatsCollection = _firebaseFirestore.collection('chats').withConverter<Chat>(
      fromFirestore: (snapshots, _) => Chat.fromJson(snapshots.data()!),
      toFirestore: (chat, _) => chat.toJson()
  );

  static Future<bool> checkIfChatExists(String uid1, String uid2) async {
    String chatID = ChatHelpers.generateChatId(uid1: uid1, uid2: uid2);

    try {
      final result = await _chatsCollection.doc(chatID).get();
      if (result != null) {
        return result.exists;
      }
      return false;
    } catch (e) {
      // Handle Firestore errors
      _logger.e('Firestore error: $e');
      return false;
    }
  }


  static Future<void> createNewChat({
    required Participant participant1,
    required Participant participant2,
  }) async {
    String chatID = ChatHelpers.generateChatId(uid1: participant1.id, uid2: participant2.id);
    final docRef = _chatsCollection.doc(chatID);

    final chat = Chat(
      id: chatID,
      participantIDs: [participant1.id, participant2.id],
      participants: [
        participant1,
        participant2,
      ],
      messages: [],
    );

    await docRef.set(chat);
  }

  static Stream<List<Chat>> getChatStreams(String userId) {
    return _firebaseFirestore
        .collection('chats')
        .where('participantIDs', arrayContains: userId, )
        .snapshots()
        .map((querySnapshot) {
      final chatDocs = querySnapshot.docs;
      // Stream transformation to handle potential empty results
      return chatDocs.isEmpty
          ? []
          : chatDocs.map((doc) => Chat.fromJson(doc.data())).toList();
    });
  }

  static Future<void> sendChatMessage({required String uid1, required String uid2, required Message message}) async {
    String chatID = ChatHelpers.generateChatId(uid1: uid1, uid2: uid2);

    final docRef = _chatsCollection.doc(chatID);

    await docRef.update({
      "messages": FieldValue.arrayUnion([message.toJson()]),
    });
  }

  static Stream<DocumentSnapshot<Chat>> getChatMessages({required String uid1, required String uid2, }){
    String chatID = ChatHelpers.generateChatId(uid1: uid1, uid2: uid2);

    return _chatsCollection.doc(chatID).snapshots() as Stream<DocumentSnapshot<Chat>>;
  }

  static Future<void> updateParticipantFcmTokenInTheDB({required String participantId, required String updatedFcmToken}) async {
    try {
      // Get all chats where the participant is involved
      final chatsQuery = _firebaseFirestore.collection('chats').where('participantIDs', arrayContains: participantId);
      final chatSnapshots = await chatsQuery.get();

      if (chatSnapshots.docs.isEmpty) {
        _logger.w('No chats found for participant $participantId');
        return;
      }

      // Loop through each chat snapshot and update the participant's FCM token
      final batch = _firebaseFirestore.batch();
      for (var doc in chatSnapshots.docs) {
        final chat = Chat.fromJson(doc.data());
        final participantIndex = chat.participants.indexWhere((participant) => participant.id == participantId);

        if (participantIndex != -1) {
          chat.participants[participantIndex].fcmToken = updatedFcmToken;
          batch.update(doc.reference, chat.toJson());
        }
      }

      await batch.commit();
    } catch (e) {
      _logger.e('Error updating participant FCM token: $e');
    }
  }

}