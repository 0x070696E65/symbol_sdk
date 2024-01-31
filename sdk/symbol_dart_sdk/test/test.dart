
//import 'package:pinenacl/api.dart';
//import '../bin/symbol/models.dart';
//import '../bin/nem/models.dart';
//import '../bin/symbol/Network.dart' as network;
import 'dart:typed_data';

//import 'package:ed25519_edwards/ed25519_edwards.dart';

//import '../bin/facade/SymbolFacade.dart';
import 'package:pinenacl/api/authenticated_encryption.dart' as pinenacl;
import 'package:http/http.dart' as http;

import '../bin/nem/Network.dart' as snt;
import '../bin/nem/models.dart';
import '../bin/nem/KeyPair.dart';
import '../bin/facade/NemFacade.dart';
import '../bin/utils/converter.dart';
import '../bin/nem/SharedKey.dart';
import '../bin/CryptoTypes.dart' as ct;
//import '../models_c.dart';
//import 'dart:convert';
//import 'dart:typed_data';
import '../bin/utils/arrayHelpers.dart';
import '../bin/symbol/idGenerator.dart';
import '../bin/NetworkTimestamp.dart';

import '../bin/symbol/Network.dart' as nt;
import 'dart:convert';

const node = 'http://95.216.73.243:7890';
void main() async {
  final res = await http.get(Uri.parse(node + '/time-sync/network-time'));
  final nodeTimeJson = jsonDecode(res.body);
  final nodeTime = nodeTimeJson['receiveTimeStamp'];
  final nemNetworkTime = NetworkTimestamp(nodeTime);

  var facade = NemFacade(snt.Network.TESTNET);
  var keyPair = KeyPair(ct.PrivateKey('37e302615d70bcf2d9088cb3f703f173e6a7a1fd0006cf1c11447e2c42cbe78a'));

  var nemMessage = Message(
    messageType: MessageType.PLAIN,
    message: utf8ToBytes('はじめてのNemトランザクション'),
  );
  var tx = TransferTransactionV1(
    network: NetworkType.TESTNET,
    signerPublicKey: PublicKey(hexToBytes('fab6f50ef6de919efd9d534416d32a0adb5b7eeba18686c958b2ac7625c7a098')),
    recipientAddress: Address('TCKCA5O7EUXTQEKHI2Z4H3MEAG52X7RRVURPMKRO'),
    timestamp: Timestamp(nemNetworkTime.timestamp ~/ 1000),
    deadline: Timestamp(facade.network.fromDatetime(DateTime.now().toUtc()).addHours(2).timestamp),
    message: nemMessage,
    fee: Amount(500000),
    amount: Amount(1000000),
  );

  var signature = facade.signTransaction(keyPair, tx);
  var transferTxPayloadJson = facade.attachSignature(tx, signature);
  var hash = facade.hashTransaction(tx);
  print(hash);

  final response = await http.post(
    Uri.parse(node + '/transaction/announce'),
    headers: {'Content-Type': 'application/json'},
    body: transferTxPayloadJson,
  );
  final announceResponseJson = jsonDecode(response.body);
  print(announceResponseJson);
}

// 0410000001000098701EE77120000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B40000000A4CF491E41929CA363AC40EE3B1045911DFD1993E4A4B106643117F51053DB3138FCE6EAC9E98FBEBD63C3D496F2E6AF900197DE5C0E2D85C4BAE4E2D43ACD4AE0FEEEEFFEEEEFFE00000000DD0000000101000002000098701EE77120000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3BE0FEEEEFFEEEEFFE000000002800000054414351364A34585841424A3446525136335A48513750474444545A43424A594B34414E4F453336414B4C000000000014000000010000000C000000476F6F64204D6F726E696E67020000002F00000023000000110000006D6173732E7375727665696C6C616E63650A000000656C656374726F6E69634E461500000000001A0000000E000000030000006E656D0300000078656D7B0100000000000003000000D40000000210000001000068701EE7712000000063512D1BD0BE9CA1697866BF3BFE50F016B2CBE0C63ECAADDFF71FE495A3DD9F40000000C1203923B6886046C7758F972E594204E227DAFF33D962C09F55D982FC1938F39F2DCFC1069F886C514A0781F5E509CA9702EBF23BD4DADA06F58B0D660AF88AE0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457D40000000210000001000068701EE771200000006402DDCC2B5846ABF7CB991FE2A8F3FA8B4A1F8DE785598FB80603E646241BB940000000026183B865EF92C671938E444DA2C27035EB3DD0DE4FD54ECE8C4B2BFF329BF5C0CEE2B12E16B8A62E386E4C98341DA20A58B6FD16FF19E658C92310A35C585FE0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457D40000000210000001000068701EE7712000000058CE6B5C5AEC68B93698468EEA1821C965AD84BC1BE5BA472C48DD4653D301D840000000781E76FB8C935524BA704C2FB8ABBDD6A179711FDBF2B8316AFF93A0E3BE8675710BE6C3692A221D1A39A45377EA0B8C7C8F1AA6083404AF302A2A684515C2D3E0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457
// 0410000001000098701EE77120000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B40000000A4CF491E41929CA363AC40EE3B1045911DFD1993E4A4B106643117F51053DB3138FCE6EAC9E98FBEBD63C3D496F2E6AF900197DE5C0E2D85C4BAE4E2D43ACD4AE0FEEEEFFEEEEFFE00000000 210100000101000002000098701EE77120000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E0FEEEEFFEEEEFFE000000002800000054414351364A34585841424A3446525136335A48513750474444545A43424A594B34414E4F453336414B4C000000000014000000010000000C000000476F6F64204D6F726E696E67020000002F00000023000000110000006D6173732E7375727665696C6C616E63650A000000656C656374726F6E69634E461500000000001A0000000E000000030000006E656D0300000078656D7B0100000000000003000000D40000000210000001000068701EE7712000000063512D1BD0BE9CA1697866BF3BFE50F016B2CBE0C63ECAADDFF71FE495A3DD9F40000000C1203923B6886046C7758F972E594204E227DAFF33D962C09F55D982FC1938F39F2DCFC1069F886C514A0781F5E509CA9702EBF23BD4DADA06F58B0D660AF88AE0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457D40000000210000001000068701EE771200000006402DDCC2B5846ABF7CB991FE2A8F3FA8B4A1F8DE785598FB80603E646241BB940000000026183B865EF92C671938E444DA2C27035EB3DD0DE4FD54ECE8C4B2BFF329BF5C0CEE2B12E16B8A62E386E4C98341DA20A58B6FD16FF19E658C92310A35C585FE0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457D40000000210000001000068701EE7712000000058CE6B5C5AEC68B93698468EEA1821C965AD84BC1BE5BA472C48DD4653D301D840000000781E76FB8C935524BA704C2FB8ABBDD6A179711FDBF2B8316AFF93A0E3BE8675710BE6C3692A221D1A39A45377EA0B8C7C8F1AA6083404AF302A2A684515C2D3E0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457
// 0410000001000098701EE77120000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B40000000A4CF491E41929CA363AC40EE3B1045911DFD1993E4A4B106643117F51053DB3138FCE6EAC9E98FBEBD63C3D496F2E6AF900197DE5C0E2D85C4BAE4E2D43ACD4AE0FEEEEFFEEEEFFE00000000 DD0000000101000002000098701EE77120000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3BE0FEEEEFFEEEEFFE000000002800000054414351364A34585841424A3446525136335A48513750474444545A43424A594B34414E4F453336414B4C000000000014000000010000000C000000476F6F64204D6F726E696E67020000002F00000023000000110000006D6173732E7375727665696C6C616E63650A000000656C656374726F6E69634E461500000000001A0000000E000000030000006E656D0300000078656D7B0100000000000003000000D40000000210000001000068701EE7712000000063512D1BD0BE9CA1697866BF3BFE50F016B2CBE0C63ECAADDFF71FE495A3DD9F40000000C1203923B6886046C7758F972E594204E227DAFF33D962C09F55D982FC1938F39F2DCFC1069F886C514A0781F5E509CA9702EBF23BD4DADA06F58B0D660AF88AE0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457D40000000210000001000068701EE771200000006402DDCC2B5846ABF7CB991FE2A8F3FA8B4A1F8DE785598FB80603E646241BB940000000026183B865EF92C671938E444DA2C27035EB3DD0DE4FD54ECE8C4B2BFF329BF5C0CEE2B12E16B8A62E386E4C98341DA20A58B6FD16FF19E658C92310A35C585FE0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457D40000000210000001000068701EE7712000000058CE6B5C5AEC68B93698468EEA1821C965AD84BC1BE5BA472C48DD4653D301D840000000781E76FB8C935524BA704C2FB8ABBDD6A179711FDBF2B8316AFF93A0E3BE8675710BE6C3692A221D1A39A45377EA0B8C7C8F1AA6083404AF302A2A684515C2D3E0FEEEEFFEEEEFFE000000002400000020000000B35451BDB43C11742AAF3C7566A5A6FC6677BE6EFB3E44CEBDB7FCB2F3FD2E3B280000005442543747414351514C59585546425351435548585857514D535244414A504143544E4A37323457