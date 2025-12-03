class AppConstants {
  // Database
  static const String databaseName = 'messages.db';
  static const int databaseVersion = 1;

  // WebView URLs
  static const String webviewUrlLocalhost = 'http://localhost:4200';
  static const String webviewUrlAndroidEmulator = 'http://10.0.2.2:4200';

  static const int typingIndicatorDelayInSeconds = 1600;

  static const List<String> agentResponses = [
    "Thanks for reaching out! How can I help you today?",
    "I'm here to assist you. What do you need help with?",
    "Got it! Let me look into that for you.",
    "That's a great question. Let me get back to you on that.",
    "I understand. I'll make sure to help you with that.",
    "Thanks for your patience! I'm checking that now.",
    "Absolutely! I can help you with that.",
    "Let me pull up that information for you.",
    "I see what you mean. Let me clarify that for you.",
    "Perfect! I'll take care of that right away.",
  ];
}