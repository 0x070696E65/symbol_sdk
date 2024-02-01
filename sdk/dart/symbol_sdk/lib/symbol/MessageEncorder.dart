import '../CryptoTypes.dart' as ct;
import '../symbol/KeyPair.dart' as sc;
import 'dart:typed_data';
import '../impl/CiperHelper.dart';
import '../utils/converter.dart';
import '../utils/arrayHelpers.dart';
import './SharedKey.dart';

final DELEGATION_MARKER = Uint8List.fromList(hexToBytes('FE2A8061577301E2'));

class MessageEncorder {
  sc.KeyPair keyPair;
  MessageEncorder(sc.KeyPair keyPair) :keyPair = keyPair;
  ct.PublicKey get publicKey => keyPair.publicKey;

  Future<Uint8List> encode(ct.PublicKey recipientPublicKey, Uint8List message) async {
    final result = await encodeAesGcm(deriveSharedKey, keyPair, recipientPublicKey, message);

    return concatArrays([
      Uint8List.fromList([1]),
      result['tag'],
      result['initializationVector'],
      result['cipherText']
    ]);
  }

  Future<Map<String, dynamic>> tryDecode(
    ct.PublicKey recipientPublicKey, Uint8List encodedMessage) async {
    if (1 == encodedMessage[0]) {
      try {
        final message = await decodeAesGcm(
            deriveSharedKey, keyPair, recipientPublicKey, encodedMessage.sublist(1));
        return {'isDecoded': true, 'message': message};
      } catch (e) {
        if (e.toString() != 'SecretBoxAuthenticationError: SecretBox has wrong message authentication code (MAC)') {
          rethrow;
        }
      }
    }

    if (0xFE == encodedMessage[0] && 0 == ArrayHelpers.deepCompare(DELEGATION_MARKER, encodedMessage.sublist(0, 8))) {
      final ephemeralPublicKeyStart = DELEGATION_MARKER.length;
      final ephemeralPublicKeyEnd = ephemeralPublicKeyStart + ct.PublicKey.SIZE;
      final ephemeralPublicKey = ct.PublicKey(encodedMessage.sublist(ephemeralPublicKeyStart, ephemeralPublicKeyEnd));

      try {
        final message = await decodeAesGcm(
            deriveSharedKey, keyPair, ephemeralPublicKey, encodedMessage.sublist(ephemeralPublicKeyEnd));
        return {'isDecoded': true, 'message': message};
      } catch (e) {
        if (e.toString() != 'Unsupported state or unable to authenticate data' && e.toString() != 'invalid point') {
          rethrow;
        }
      }
    }

    return {'isDecoded': false, 'message': encodedMessage};
  }
}