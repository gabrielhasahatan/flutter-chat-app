import 'package:app_chat/services/auth_service.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: Column(
        children: [
          Text("MY MAIN"),
          TextButton(
              onPressed: () async {
                _authService.signOut(); 
              },
              child: Text("LOGOUT"))
        ],
      ),
    );
  }
}
