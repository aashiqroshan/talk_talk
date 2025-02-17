import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talk_talk/components/chat_bubble.dart';
import 'package:talk_talk/components/my_textfield.dart';
import 'package:talk_talk/services/auth/auth_service.dart';
import 'package:talk_talk/services/chat/chat_service.dart';

class Chatpage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  Chatpage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode myFocusnode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState

    myFocusnode.addListener(
      () {
        if (myFocusnode.hasFocus) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => scrollDown(),
          );
        }
      },
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    myFocusnode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendmessage(
          widget.receiverID, _messageController.text);

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading....');
        }
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.bottomLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(isCurrentUser: isCurrentUser, message: data['message']),
          ],
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
                  hinttext: 'Type a message',
                  focusNode: myFocusnode,
                  obscureText: false,
                  controller: _messageController)),
          Container(
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)),
          )
        ],
      ),
    );
  }
}
