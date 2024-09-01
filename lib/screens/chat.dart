import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  
  // Load API key from environment variable
  final String apiKey = Platform.environment['AIzaSyBL_LQtxml6YxvEzzPM-2l4TtOfhgV00J8'] ?? '';

  @override
  void initState() {
    super.initState();
  }

Future<void> _sendMessage(String message) async {
  setState(() {
    _messages.add({'sender': 'user', 'text': message});
  });
  _controller.clear();

  try {
    final response = await _makeApiRequest(message);
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final botResponse = data['response']?['text'] ?? 'No response from bot';
      setState(() {
        _messages.add({'sender': 'bot', 'text': botResponse});
      });
    } else {
      setState(() {
        _messages.add({'sender': 'bot', 'text': 'Error: Unable to get a response.'});
      });
    }
  } catch (e) {
    setState(() {
      _messages.add({'sender': 'bot', 'text': 'Error: ${e.toString()}'});
    });
  }
}

  Future<http.Response> _makeApiRequest(String message) {
  return http.post(
    Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyBL_LQtxml6YxvEzzPM-2l4TtOfhgV00J8'), // Replace with your actual API endpoint
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'message': message,
      'context': _messages.isEmpty ? null : _messages.last, // Optional context for conversation flow
    }),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return ListTile(
                  title: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message['text'] ?? '',
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your message...',
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
