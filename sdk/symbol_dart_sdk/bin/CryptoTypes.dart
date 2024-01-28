import './ByteArray.dart';
import 'dart:typed_data';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;

class Hash256 extends ByteArray {
  static const SIZE = 32;

  Hash256(dynamic hash256) : super(SIZE, hash256);

  static Hash256 zero() {
    return Hash256(Uint8List(SIZE));
  }
}

class PrivateKey extends ByteArray {
  static const SIZE = 32;

  PrivateKey(dynamic privateKey) : super(SIZE, privateKey);

  static PrivateKey random() {
    return PrivateKey(ed.generateKey().privateKey.bytes.sublist(SIZE));
  }
}

class PublicKey extends ByteArray {
  static const SIZE = 32;

  PublicKey(dynamic publicKey)
      : super(SIZE, publicKey is PublicKey ? publicKey.bytes : publicKey);
}

class SharedKey256 extends ByteArray {
  static const SIZE = 32;

  SharedKey256(dynamic sharedKey) : super(SIZE, sharedKey);
}

class Signature extends ByteArray {
  static const SIZE = 64;

  Signature(dynamic signature) : super(SIZE, signature);

  static Signature zero() {
    return Signature(Uint8List(SIZE));
  }
}