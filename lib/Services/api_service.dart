import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Controllers/chat_controller.dart';
import '../Models/chat_completion_model.dart';

enum TtsState { playing, stopped, paused, continued }

class ApiService {
  final List<Map<String, String>> conversation = [
    {'role': 'system', 'content': ChatController.basePrompt}
  ];

  final String baseUrl = 'https://api.openai.com/v1/chat/completions';
  static FlutterTts flutterTts = FlutterTts();
  double volume = 0.7;
  double pitch = 1.0;
  double rate = 0.4;
  Map<String, String>? voice;

  bool isCurrentLanguageInstalled = false;

  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  dynamic initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
  }

  Future<void> _speak(List<String> resp) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    await flutterTts.speak(resp.join(" ".replaceAll(",", "")));
    Get.find<ChatController>().startListening();

    // if (_newVoiceText != null) {
    //   if (_newVoiceText!.isNotEmpty) {
    //     await flutterTts.speak(_newVoiceText!);
    //   } else {
    //     print("Text to speak is empty");
    //   }
    // }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    // Fetch the list of available voices
    List<dynamic> voices = await flutterTts.getVoices;
    print("Voices: $voices");

    // Find the en-AU-language voice
    var selectedVoice = voices.firstWhere(
      (voice) => voice['locale'] == 'en-AU',
      orElse: () => null,
    );

    if (selectedVoice != null) {
      voice = {
        'name': selectedVoice['name'],
        'locale': selectedVoice['locale'],
      };
      await flutterTts.setVoice(voice!);
      print("Selected voice: ${voice}");
    } else {
      print("Desired voice not found.");
    }

    if (voice != null) {
      print(voice);
    }
  }

  Future<String?> getChatCompletion(
      {required String prompt,
      required String model,
      required String basePrompt}) async {
    conversation.add({'role': 'user', 'content': prompt});
    List<String> resp = [];
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['apiKey']}',
      },
      body: jsonEncode({
        'model': model,
        'stream': true,
        'temperature': 0,
        'messages': conversation,
      }),
    );
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      //print all the chunks received
      // Split the chunked response on new lines and parse each part
      for (var line in response.body.split('\n')) {
        if (line.isNotEmpty) {
          if (line == 'data: [DONE]') {
            conversation.add({'role': 'assistant', 'content': resp.join(" ")});
            print("Conversation: $conversation");
            await _speak(resp);
            print('[DONE]');
            resp.clear();
            return null;
          } else {
            // Remove "data: " prefix
            final jsonString = line.substring(6);
            final Map<String, dynamic> jsonData = jsonDecode(jsonString);
            final chatChunk = ChatCompletionChunk.fromJson(jsonData);
            for (var choice in chatChunk.choices) {
              if (choice.delta.content != null) {
                print("Message: ${choice.delta.content!}");
                resp.add(choice.delta.content!);

                // if (resp.length > 10) {
                //   await _speak(resp);
                //   resp.clear();
                // }
              }
            }
          }
        }
      }

      return null;
    } else {
      throw Exception('Failed to load chat completion');
    }
  }
}
