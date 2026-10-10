import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AiScanState {
  final bool isScanning;
  final String selectedMode;
  final List<ChatMessage> chatMessages;

  const AiScanState({
    required this.isScanning,
    required this.selectedMode,
    required this.chatMessages,
  });

  AiScanState copyWith({
    bool? isScanning,
    String? selectedMode,
    List<ChatMessage>? chatMessages,
  }) {
    return AiScanState(
      isScanning: isScanning ?? this.isScanning,
      selectedMode: selectedMode ?? this.selectedMode,
      chatMessages: chatMessages ?? this.chatMessages,
    );
  }
}

class AiScanNotifier extends StateNotifier<AiScanState> {
  AiScanNotifier()
      : super(
          AiScanState(
            isScanning: false,
            selectedMode: 'Disease Diagnosis',
            chatMessages: [
              ChatMessage(
                text: "Hello! I'm Agro AI Assistant. Take a photo of your crop or ask me any question about farming, pest control, or fertilizer.",
                isUser: false,
                timestamp: DateTime.now(),
              ),
            ],
          ),
        );

  void setMode(String mode) {
    state = state.copyWith(selectedMode: mode);
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final userMsg = ChatMessage(text: text, isUser: true, timestamp: DateTime.now());
    final currentMsgs = List<ChatMessage>.from(state.chatMessages)..add(userMsg);
    
    state = state.copyWith(chatMessages: currentMsgs, isScanning: true);

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1000), () {
      final aiMsg = ChatMessage(
        text: "Based on your inquiry about '$text', I recommend inspecting leaf moisture and applying balanced NPK organic fertilizer.",
        isUser: false,
        timestamp: DateTime.now(),
      );
      state = state.copyWith(
        chatMessages: [...state.chatMessages, aiMsg],
        isScanning: false,
      );
    });
  }
}

final aiScanProvider = StateNotifierProvider<AiScanNotifier, AiScanState>((ref) {
  return AiScanNotifier();
});
