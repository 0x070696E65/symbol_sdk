import 'dart:typed_data';
import 'utils/converter.dart';

class ByteArray {
  Uint8List bytes;

  ByteArray(int fixedSize, dynamic arrayInput)
      : bytes = Uint8List(fixedSize) {
    var rawBytes = arrayInput;
    if (rawBytes is String) {
      try {
        if (isHexString(rawBytes)) {
          rawBytes = hexToBytes(rawBytes);
        } else {
          rawBytes = stringToAddress(arrayInput);
        }
      } catch (e) {
        throw ArgumentError('bytes was not a valid hex or address string');
      }
    }

    if (fixedSize != rawBytes.length) {
      throw RangeError('bytes was size ${rawBytes.length} but must be $fixedSize');
    }

    bytes = Uint8List.fromList(rawBytes);
  }

  @override
  String toString() {
    try {
      return addressToString(bytes);
    } catch(_) {
      return bytesToHex(bytes).toUpperCase();
    }
  }

  bool get isDefault{
    return bytes.every((byte) => byte == 0);
  }
}