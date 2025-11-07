import 'package:app_chat/const.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _addChat(chat) {
    setState(() {
      Chat.add(chat);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 250),
  //       curve: Curves.easeOut,
  //     );
  //   }
  // }

  void _sendChatHandle() {
    _addChat({"sender": true, "data": _chatController.text});
    _chatController.text = "";
    _scrollToBottom();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: Center(
          child: Text("Wak Haji"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: Chat.length,
                itemBuilder: (context, index) {
                  final data = Chat[index];

                  return BubbleSpecialThree(
                    text: '${data['data']}',
                    color: data['sender']
                        ? Color.fromARGB(255, 27, 243, 74)
                        : Color.fromARGB(255, 83, 83, 90),
                    isSender: data['sender'],
                    tail: false,
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                  );
                }),
          ),
          Container(
            color: Colors.grey[200],
            height: 70,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 1.0, 8.0, 1.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      controller: _chatController,
                    ),
                  ),
                  TextButton(
                      style: ButtonStyle(
                          iconColor: WidgetStatePropertyAll(Colors.black),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0))),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blue[200])),
                      onPressed: () {
                        _chatController.text != "" ? _sendChatHandle() : null;
                      },
                      child: const Icon(
                        Icons.send,
                        size: 50,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
