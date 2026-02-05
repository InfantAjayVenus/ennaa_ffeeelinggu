import 'package:ennaa_ffeeelinggu/src/utils/emoji_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmojiHelper', () {
    test('getEmoji returns correct emoji for mood score', () {
      expect(EmojiHelper.getEmoji(1), '😭');
      expect(EmojiHelper.getEmoji(5), '😐');
      expect(EmojiHelper.getEmoji(10), '😂');
      expect(EmojiHelper.getEmoji(0), '😐'); // Test out of range
      expect(EmojiHelper.getEmoji(11), '😐'); // Test out of range
    });
  });
}
