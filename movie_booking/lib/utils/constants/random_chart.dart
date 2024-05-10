import 'dart:math';

String generateRandomString() {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789'; // Tập hợp các ký tự sử dụng
  final random = Random();
  String result = '';

  for (var i = 0; i < 6; i++) {
    final index = random.nextInt(characters.length);
    result += characters[index];
  }

  return result;
}