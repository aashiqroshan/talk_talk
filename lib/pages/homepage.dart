import 'package:flutter/material.dart';
import 'package:talk_talk/components/user_Tile.dart';
import 'package:talk_talk/pages/ChatPage.dart';
import 'package:talk_talk/services/auth/auth_service.dart';
import 'package:talk_talk/components/my_drawer.dart';
import 'package:talk_talk/services/chat/chat_service.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading......');
        }
        return ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userData) => _buildUserListItem(userData, context),
                )
                .toList());
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chatpage(
                    receiverEmail: userData['email'],
                    receiverID: userData['uid'],
                  ),
                ));
          },
          text: userData["email"]);
    } else {
      return Container();
    }
  }
}
