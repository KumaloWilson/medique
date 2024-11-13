import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:medique/core/constants/url_config.dart';
import '../../../models/chat.dart';
import '../../../models/message.dart';
import '../../../models/participants.dart';
import '../../core/constants/color_constants.dart';
import '../../global/global.dart';
import '../../services/chat_services.dart';
import '../../widgets/snackbar/custom_snackbar.dart';

class ChatBotScreen extends StatefulWidget {
  final String disease;
  const ChatBotScreen({super.key, required this.disease});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  ChatUser? currentUser, otherUser;
  final user = FirebaseAuth.instance.currentUser;
  final Logger _logger = Logger();
  bool isLoadingResponse = false;

  @override
  void initState() {
    super.initState();

    currentUser = ChatUser(id: user!.uid, firstName: user!.displayName);

    otherUser = ChatUser(
        id: 'MediGuideAIAssistantChatBot001',
        firstName: 'MediGuide Assistant',
        profileImage:
            'https://cdn-icons-png.flaticon.com/128/3558/3558866.png');

    checkIfChatExists();
  }

  void checkIfChatExists() async {
    final chatExist =
        await ChatServices.checkIfChatExists(currentUser!.id, otherUser!.id);

    if (!chatExist) {
      await ChatServices.createNewChat(
          participant1: Participant(
              id: user!.uid,
              displayName: user!.displayName ?? '',
              email: user!.email ?? '',
              profilePicture: user!.photoURL ?? '',
              fcmToken: ''),
          participant2: Participant(
              id: otherUser!.id,
              displayName: otherUser!.firstName!,
              email: 'MediGuideAssistant@mediguide.com',
              profilePicture:
                  'https://cdn-icons-png.flaticon.com/128/3558/3558866.png',
              fcmToken: ''));

      _logger.i('Chat Created Successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.primaryColor,
          leadingWidth: 80,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    otherUser!.profileImage.toString().isNotEmpty
                        ? otherUser!.profileImage.toString()
                        : 'https://cdn-icons-png.flaticon.com/128/3177/3177440.png',
                  ),
                )
              ],
            ),
          ),
          title: const Text(
            'MediGuide Assistant',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        body: _buildChatUI());
  }

  Widget _buildChatUI() {
    return StreamBuilder<DocumentSnapshot<Chat>>(
        stream: ChatServices.getChatMessages(
            uid1: currentUser!.id, uid2: otherUser!.id),
        builder: (context, snapshot) {
          Chat? chat = snapshot.data?.data();
          List<ChatMessage> messages = [];

          if (chat != null && chat.messages != null) {
            messages = _generateChatMessagesList(chat.messages);
          }

          if (isLoadingResponse) {
            messages.insert(0, _loadingBubble());
          }

          return DashChat(
              messageOptions: const MessageOptions(
                  showOtherUsersAvatar: true, showTime: true),
              currentUser: currentUser!,
              messages: messages,
              onSend: _sendMessage);
        });
  }

  Future<void> _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      isLoadingResponse = true; // Show loading bubble when sending a message
    });

    Message message = Message(
        senderID: currentUser!.id,
        content: chatMessage.text,
        messageType: MessageType.text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt));

    await ChatServices.sendChatMessage(
        uid1: currentUser!.id, uid2: otherUser!.id, message: message);

    await sendPrompt(chatMessage.text);
  }

  Future<void> sendPrompt(String prompt) async {
    var url = Uri.parse('${UrlConfig.ragUrl}/get_response');

    try {
      // Prepare form data
      var body = {'query': prompt};

      // Send the POST request with application/x-www-form-urlencoded headers
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body,
      );

      if (response.statusCode == 200) {
        // Decode the JSON response
        var data = jsonDecode(response.body);

        // Check if the required keys are available
        if (data.containsKey("answer") &&
            data.containsKey("source_document") &&
            data.containsKey("doc")) {
          // Construct the message
          Message message = Message(
            senderID: otherUser!.id,
            content:
                '${data["answer"]}\n\n\nContext: ${data["source_document"]}\n\nSource Document: ${data["doc"]}',
            messageType: MessageType.text,
            sentAt: Timestamp.fromDate(DateTime.now()),
          );

          // Send the message using your chat service
          await ChatServices.sendChatMessage(
            uid1: otherUser!.id,
            uid2: currentUser!.id,
            message: message,
          );

          _logger.i('Response returned successfully');
        } else {
          // Handle unexpected structure in the response
          _logger.e("Unexpected response structure: $data");
          CustomSnackBar.showErrorSnackbar(
              message: "Unexpected response from the server.");
        }
      } else {
        // Handle non-200 responses
        _logger.e("Failed: ${response.statusCode}");
        CustomSnackBar.showErrorSnackbar(
            message:
                "Failed to get response. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Catch and log any errors
      _logger.e(e);
      CustomSnackBar.showErrorSnackbar(message: 'An error occurred: $e');
    } finally {
      // Hide loading bubble after response is received or in case of error
      setState(() {
        isLoadingResponse = false;
      });
    }
  }

  List<ChatMessage> _generateChatMessagesList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((message) {
      if (message.messageType == MessageType.image) {
        return ChatMessage(
            user:
                message.senderID == currentUser!.id ? currentUser! : otherUser!,
            medias: [
              ChatMedia(
                  url: message.content!, fileName: '', type: MediaType.image)
            ],
            createdAt: message.sentAt!.toDate());
      } else {
        return ChatMessage(
            user:
                message.senderID == currentUser!.id ? currentUser! : otherUser!,
            text: message.content!,
            createdAt: message.sentAt!.toDate());
      }
    }).toList();

    chatMessages.sort((a, b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    return chatMessages;
  }

  ChatMessage _loadingBubble() {
    return ChatMessage(
      user: otherUser!,
      createdAt: DateTime.now(),
      text: '...',
    );
  }
}
