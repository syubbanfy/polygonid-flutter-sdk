import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:privadoid_sdk/jwz_token.dart';
import 'package:privadoid_sdk/model/jwz/jwz_header.dart';
import 'package:privadoid_sdk/model/jwz/jwz_proof.dart';
import 'package:privadoid_sdk/utils/Base64.dart';

/// JSON Web Zero-knowledge (JWZ) is an open standard
/// for representing messages proven by zero-knowledge technology.
class JWZ extends Equatable with Base64Encoder implements JWZHashPreparer {
  JWZHeader? header;
  final dynamic payload;
  JWZProof? proof;

  JWZ({this.header, required this.payload, this.proof});

  factory JWZ.fromBase64(String data) {
    var split = data.split(".");

    return JWZ(
        header: JWZHeader.fromBase64(split[0]),
        payload: Base64Util.decode(split[1]),
        proof: split.length == 3 ? JWZProof.fromBase64(split[2]) : null);
  }

  @override
  String encode() {
    return "${header?.encode()}.${Base64Util.encode64(payload)}.${proof?.encode()}";
  }

  @override
  List<Object?> get props => [header, payload, proof];

  @override
  Uint8List prepareForHash() {
    return Uint8List.fromList(
        "${header?.encode()}.${Base64Util.encode64(payload)}".codeUnits);
  }
}
