import 'dart:io';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:convert/convert.dart';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

void signTest(String path) async {
  var file = File(path);
  var contents = await file.readAsString();
  var jsonMap = jsonDecode(contents);
  final digest = SHA3Digest(256);
  (jsonMap as List).forEach((element) {
    test(element['hash'], () {
      var data = Uint8List.fromList(hex.decode(element['data']));
      var hash = hex.encode(digest.process(data)).toUpperCase();
      expect(element['hash'], hash);
    });
  });
}
void main() async {
  signTest('../../../../../symbol/tests/vectors/symbol/crypto/0.test-sha3-256.json');
}
