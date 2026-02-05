class EmojiHelper {
  static String getEmoji(int mood) {
    final Map<int, String> emojis = {
      1: '😭',
      2: '😞',
      3: '😧',
      4: '😦',
      5: '😐',
      6: '😏',
      7: '🙂',
      8: '😀',
      9: '😁',
      10: '😂',
    };
    return emojis[mood] ?? '😐';
  }
}
