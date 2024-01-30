
//import 'package:pinenacl/api.dart';
//import '../bin/symbol/models.dart';
//import '../bin/nem/models.dart';
//import '../bin/symbol/Network.dart' as network;
import '../bin/symbol/models.dart';
import '../bin/utils/converter.dart';
//import '../models_c.dart';
//import 'dart:convert';
//import 'dart:typed_data';
import '../bin/utils/arrayHelpers.dart';

void main() async {
  var payload = '28010000000000006A1C14B723E973CC450165EFC629DCAC65F0A9B70517F27BD426BFEB9C21E33C91699BCDF34A0464DBA8D4A7237E4A4309139F2E9378BEC7B67C7EA1F92D5DC683D1CD2DA160075F016CC04B51397186FEF67006364D851DA9EB0CF3E886E3720000000002984142E0FEEEEFFEEEEFFEE0711EE7711EE771553D90AFA4B171840BCBA16DB6F82A767C98344D5F6D5F2B0B05A8902D01BD4D800000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000198504101000201000000009841E5B8E40781CF74DABF592817DE48711D778648DEAFB298F409274B52FABBFBCF7E7DF7E20DE1D0C3F657FB8595C1989059321905F681BCF47EA33BBF5E6F8298B5440854FDED';
    var tx = AggregateBondedTransactionV2(
      network: NetworkType.TESTNET,
      transactions: [
        EmbeddedAccountAddressRestrictionTransactionV1(
          network: NetworkType.TESTNET,
          restrictionFlags: AccountRestrictionFlags.ADDRESS,
          restrictionAdditions: [
            UnresolvedAddress('TBA6LOHEA6A465G2X5MSQF66JBYR254GJDPK7MQ'),
            UnresolvedAddress('TD2ASJ2LKL5LX66PPZ67PYQN4HIMH5SX7OCZLQI')
          ],
          restrictionDeletions: [
            UnresolvedAddress('TCIFSMQZAX3IDPHUP2RTXP26N6BJRNKEBBKP33I')
          ],
        )
      ],
      signerPublicKey: PublicKey('83D1CD2DA160075F016CC04B51397186FEF67006364D851DA9EB0CF3E886E372'),
      signature: Signature('6A1C14B723E973CC450165EFC629DCAC65F0A9B70517F27BD426BFEB9C21E33C91699BCDF34A0464DBA8D4A7237E4A4309139F2E9378BEC7B67C7EA1F92D5DC6'),
      fee: Amount('18370164183782063840'),
      deadline: Timestamp(8207562320463688160),
      cosignatures: [],
      transactionsHash: Hash256('553D90AFA4B171840BCBA16DB6F82A767C98344D5F6D5F2B0B05A8902D01BD4D')
    );
  print(tx);
  print(bytesToHex(tx.serialize()));
}
// 0101000001000098701EE77120000000B0A48186B2D8C168DBAF2395AD3BF421F9E44D7AD8E616C5E981ABD1DB5190F24000000042D030CD0166DA62C1DF1FF0945752475FBD2B4B975E9991EFF57BCD742C235787433B8AF428C3852009C8C63B632572057945118F393F4187FF51DFD77CAC6DE0FEEEEFFEEEEFFE000000002800000054414351364A34585841424A3446525136335A48513750474444545A43424A594B34414E4F453336401E92589800000000000000
// 0101000001000098701EE77120000000B0A48186B2D8C168DBAF2395AD3BF421F9E44D7AD8E616C5E981ABD1DB5190F24000000042D030CD0166DA62C1DF1FF0945752475FBD2B4B975E9991EFF57BCD742C235787433B8AF428C3852009C8C63B632572057945118F393F4187FF51DFD77CAC6DE0FEEEEFFEEEEFFE000000002800000054414351364A34585841424A3446525136335A48513750474444545A43424A594B34414E4F453336401E925898000000080000000100000000000000
// 0101000001000098701EE77120000000B0A48186B2D8C168DBAF2395AD3BF421F9E44D7AD8E616C5E981ABD1DB5190F24000000042D030CD0166DA62C1DF1FF0945752475FBD2B4B975E9991EFF57BCD742C235787433B8AF428C3852009C8C63B632572057945118F393F4187FF51DFD77CAC6DE0FEEEEFFEEEEFFE000000002800000054414351364A34585841424A3446525136335A48513750474444545A43424A594B34414E4F453336401E92589800000000000000