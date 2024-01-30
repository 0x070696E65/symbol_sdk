import 'package:test/test.dart';
import 'dart:typed_data';
import '../../../bin/symbol/models.dart';
import '../../../bin/utils/converter.dart';
import '../../../bin/models/StructBase.dart';

void blocksTest() async {
  test('NormalBlockV1_block_1', () {
    var payload = '7801000000000000419FC54551678B7AC1977B5BD596E71BF94B27735204B8B17F033F3EEDBBEC568A66AA4D667CF1DA90978255B983D930D3BD22044BF5CB4795A63678AF2183583406720CAB047EAC3DD8A3E14BF42ADED7FCDCE3F8124949856B01BCC2E0A9F000000000019843818C950B0000000000E0711EE7711EE77100A0724E1809000061F452701D1A1DD50406DDD98EC2E76F939F79A39243A1095F486835AAB7FB422C947E8F590D97B7578802BEF392E1D170D7791DC59772F69909F6387B3F2EBBD1FAAEFC71487043039A1B79319D730E4FC9BB3EF6799E98193253CE89F6D80C5424FAE0E194EF8279C27CD776F4E204BC2EDB6C9E0FD86BEF9CBB2C7E85D761834D5E211718D7FFB0F3A605341808A17AB373A6793CB7B9532DD5413D00DB92AB5F676BCF21BA847678A5AC59457E223E39A5626FE62867C1E392322A7EAA5CCABAB38AD2E363E30430989178AAF9F6988DE70F51DEE436904E8D0D41FADE0D49758981293DAB08C712000000000000';
    var block = NormalBlockV1(
      network: NetworkType.TESTNET,
      height: Height(759180),
      difficulty: Difficulty(10000000000000),
      generationHashProof: VrfProof(
        gamma: ProofGamma('61F452701D1A1DD50406DDD98EC2E76F939F79A39243A1095F486835AAB7FB42'),
        verificationHash: ProofVerificationHash('2C947E8F590D97B7578802BEF392E1D1'),
        scalar: ProofScalar('70D7791DC59772F69909F6387B3F2EBBD1FAAEFC71487043039A1B79319D730E')
      ),
      previousBlockHash: Hash256('4FC9BB3EF6799E98193253CE89F6D80C5424FAE0E194EF8279C27CD776F4E204'),
      transactionsHash: Hash256('BC2EDB6C9E0FD86BEF9CBB2C7E85D761834D5E211718D7FFB0F3A605341808A1'),
      receiptsHash: Hash256('7AB373A6793CB7B9532DD5413D00DB92AB5F676BCF21BA847678A5AC59457E22'),
      stateHash: Hash256('3E39A5626FE62867C1E392322A7EAA5CCABAB38AD2E363E30430989178AAF9F6'),
      beneficiaryAddress: Address('TCG6OD2R33SDNECORUGUD6W6BVEXLCMBFE62WCA'),
      feeMultiplier: BlockFeeMultiplier(4807),
      transactions: [],
      signature: Signature('419FC54551678B7AC1977B5BD596E71BF94B27735204B8B17F033F3EEDBBEC568A66AA4D667CF1DA90978255B983D930D3BD22044BF5CB4795A63678AF218358'),
      signerPublicKey: PublicKey('3406720cab047eac3dd8a3e14bf42aded7fcdce3f8124949856b01bcc2e0a9f0'),
      timestamp: Timestamp(8207562320463688160)
      );
    expect(bytesToHex(block.serialize()), payload);
    expect(bytesToHex((BlockFactory().deserialize(payload) as StructBase).serialize()), payload);
  });
  test('NemesisBlockV1_block_2', () {
    var payload = '72020000000000006230367CBE456B4BB32B9CBBDC94CEA2DB15BB4548F267E4FEBDC72C6FFEBA8EB861C6BA7367CC51C3321C8B85EF515E583DD8A1300121DFF3B4A82864B3546D6AAFD4B7C899B50080BA445C3D17D8D56724C1F460AA3B58DE73E58E555009AC000000000198438048AC0B0000000000E0711EE7711EE77112731ED32F09000031EDB0B110FB7116BD835CFE9206EDC6033C466DE213F5F28B2619A74DF4022459DE3A1EBE9B8F4E78B00AEBC6BF122CD846AF0FC2A123F7012FDF882F73476939A620B61A07FC8FA321229664B79507491CB2272CAF0CD4F0EBA918A5AD4E2F9BFF9C6B0BF183BC461B6E9B756CF4350000000000000000000000000000000000000000000000000000000000000000691B47DD6DFC468883A48E73FFD22FCBA141A2371AD09376357E547C55C5C24C947B5EFB1C5FAF95BF294A6E020830203CFB9CCE6597E6ACF3C16C06CCAEB87398FFA418508A3B022EF3491FC8254DEB7EC3EBA65B52DE1DBB1E00000E000000DE01000000000000A2432277446A0000DBDC925119781952C316DE84B87DAC640F64B899E191A7190EBCFDDED482A75DCA000000000000006230367CBE456B4BB32B9CBBDC94CEA2DB15BB4548F267E4FEBDC72C6FFEBA8EB861C6BA7367CC51C3321C8B85EF515E583DD8A1300121DFF3B4A82864B3546D6AAFD4B7C899B50080BA445C3D17D8D56724C1F460AA3B58DE73E58E555009AC0000000001985441E0FEEEEFFEEEEFFEE0711EE7711EE771989059321905F681BCF47EA33BBF5E6F8298B5440854FDED0A00020000000000671305C6390B00002C01000000000000672B0000CE560000640000000000000048656C6C6F20F09F918B';
    var block = NemesisBlockV1(
      network: NetworkType.TESTNET,
      height: Height(765000),
      difficulty: Difficulty(10101010101010),
      generationHashProof: VrfProof(
        gamma: ProofGamma('31EDB0B110FB7116BD835CFE9206EDC6033C466DE213F5F28B2619A74DF40224'),
        verificationHash: ProofVerificationHash('59DE3A1EBE9B8F4E78B00AEBC6BF122C'),
        scalar: ProofScalar('D846AF0FC2A123F7012FDF882F73476939A620B61A07FC8FA321229664B79507')
      ),
      previousBlockHash: Hash256('491CB2272CAF0CD4F0EBA918A5AD4E2F9BFF9C6B0BF183BC461B6E9B756CF435'),
      transactionsHash: Hash256('0000000000000000000000000000000000000000000000000000000000000000'),
      receiptsHash: Hash256('691B47DD6DFC468883A48E73FFD22FCBA141A2371AD09376357E547C55C5C24C'),
      stateHash: Hash256('947B5EFB1C5FAF95BF294A6E020830203CFB9CCE6597E6ACF3C16C06CCAEB873'),
      beneficiaryAddress: Address('TD72IGCQRI5QELXTJEP4QJKN5N7MH25GLNJN4HI'),
      feeMultiplier: BlockFeeMultiplier(7867),
      votingEligibleAccountsCount: 14,
      harvestingEligibleAccountsCount: 478,
      totalVotingBalance: Amount(116842289054626),
      previousImportanceBlockHash: Hash256('DBDC925119781952C316DE84B87DAC640F64B899E191A7190EBCFDDED482A75D'),
      transactions: [
        TransferTransactionV1(
          network: NetworkType.TESTNET,
          recipientAddress: UnresolvedAddress('TCIFSMQZAX3IDPHUP2RTXP26N6BJRNKEBBKP33I'),
          mosaics: [
            UnresolvedMosaic(
              mosaicId: UnresolvedMosaicId(12342763262823),
              amount: Amount(300)
            ),
            UnresolvedMosaic(
              mosaicId: UnresolvedMosaicId(95442763262823),
              amount: Amount(100)
            ),
          ],
          message: utf8ToBytes('Hello \ud83d\udc4b'),
          signature: Signature('6230367CBE456B4BB32B9CBBDC94CEA2DB15BB4548F267E4FEBDC72C6FFEBA8EB861C6BA7367CC51C3321C8B85EF515E583DD8A1300121DFF3B4A82864B3546D'),
          signerPublicKey: PublicKey('6AAFD4B7C899B50080BA445C3D17D8D56724C1F460AA3B58DE73E58E555009AC'),
          fee: Amount('18370164183782063840'),
          deadline: Timestamp(8207562320463688160)
        )
      ],
      signature: Signature('6230367CBE456B4BB32B9CBBDC94CEA2DB15BB4548F267E4FEBDC72C6FFEBA8EB861C6BA7367CC51C3321C8B85EF515E583DD8A1300121DFF3B4A82864B3546D'),
      signerPublicKey: PublicKey('6aafd4b7c899b50080ba445c3d17d8d56724c1f460aa3b58de73e58e555009ac'),
      timestamp: Timestamp(8207562320463688160)
      );
    expect(bytesToHex(block.serialize()), payload);
    expect(bytesToHex((BlockFactory().deserialize(payload) as StructBase).serialize()), payload);
  });
  test('ImportanceBlockV1_block_3', () {
    var payload = '9204000000000000779F663E37728DE17E16085C753D8831BFE65380936F7233BF3D38986803361003B840B68A899CEBF651A5F5DE0E4AE1E992C3E94234A9903DBE155814426A6A3BB09D6DA59708F9D93C9B4AB8AE5DCB826A6412D740CCD038D50CEF6E52EB3B0000000001984382B0AD0B0000000000E0711EE7711EE77112731ED32F09000042C7BE9082B10689005D62F85824B44D2AEA3444FAC5B66C09A80EC357B568F7B710A9B2447DF32800BA3ADADD58B4E8035B2CD3F6810540FB34C5F4500CFD0550EBF54EDC42B7F7622069B4A0AC920C12D82BCC77171D8534629100B7FA10C2F0BF866B53542FAAECC421F4C8A9BB2A0000000000000000000000000000000000000000000000000000000000000000B72E10BC0AF282BE231EA7B434C331F4597494F2C9E805F40BA4CDFBF3C8F619BE371A51908393A47B6E69E75B80CA9017E12CDCE87A67FC811BD58D6437657B988C91EC5E79836DD1C549E3AAAEACFD02F69A364F809BB2000000000E000000DF010000000000007B068C034F6A000077C5CD0D6B7BD6A0E62FC3910A13D764848C5DCECF176E04FA700E033F0457532002000000000000779F663E37728DE17E16085C753D8831BFE65380936F7233BF3D38986803361003B840B68A899CEBF651A5F5DE0E4AE1E992C3E94234A9903DBE155814426A6A3BB09D6DA59708F9D93C9B4AB8AE5DCB826A6412D740CCD038D50CEF6E52EB3B0000000001984142E0FEEEEFFEEEEFFEE0711EE7711EE771D888625D77638015FA727BDCCCDC8CEE715CBAF7804F9F39EDC6DFE8536FEB1EA800000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000001985441989059321905F681BCF47EA33BBF5E6F8298B5440854FDED00000100000000008869746E9B1A70576400000000000000410000000000000000000000000000000000000000000000000000000000000000000000000000000000000001984D42671305C6390B00000B000000000000000100000000000000000000000000000094873EEEEA7E7B71A0755484AEF901805C8AAFA96CFD36BFC8827D52F0D1F17484EB28BA49DF25EA464A9FB02327C508BE0E982A15CCC4DBC93F3216DE3C9500016AD0960CD98904FDEE031DA15EA683A65016F5E94FB742590B71F23EE56D2E000000000000000078C8B3878D40D868195B1DDAA5DFAA5A784878F5FA1F24F7DEF27213F2F727A0DD4E615209BC6B8B3D204FFB17F80A08F4BA3891FAD9BF1EECF336E659091C0E8CDFF802555E2DAF19A3A7706ABF4F9CC7406D4CF5FAC3CC5BBDF72D4E7A1808CA00000000000000779F663E37728DE17E16085C753D8831BFE65380936F7233BF3D38986803361003B840B68A899CEBF651A5F5DE0E4AE1E992C3E94234A9903DBE155814426A6A3BB09D6DA59708F9D93C9B4AB8AE5DCB826A6412D740CCD038D50CEF6E52EB3B0000000001985441E0FEEEEFFEEEEFFEE0711EE7711EE7719841E5B8E40781CF74DABF592817DE48711D778648DEAFB20A00020000000000671305C6390B00002C01000000000000672B0000CE560000640000000000000048656C6C6F20F09F918B';
    var block = ImportanceBlockV1(
      network: NetworkType.TESTNET,
      height: Height(765360),
      difficulty: Difficulty(10101010101010),
      generationHashProof: VrfProof(
        gamma: ProofGamma('42C7BE9082B10689005D62F85824B44D2AEA3444FAC5B66C09A80EC357B568F7'),
        verificationHash: ProofVerificationHash('B710A9B2447DF32800BA3ADADD58B4E8'),
        scalar: ProofScalar('035B2CD3F6810540FB34C5F4500CFD0550EBF54EDC42B7F7622069B4A0AC920C')
      ),
      previousBlockHash: Hash256('12D82BCC77171D8534629100B7FA10C2F0BF866B53542FAAECC421F4C8A9BB2A'),
      transactionsHash: Hash256('0000000000000000000000000000000000000000000000000000000000000000'),
      receiptsHash: Hash256('B72E10BC0AF282BE231EA7B434C331F4597494F2C9E805F40BA4CDFBF3C8F619'),
      stateHash: Hash256('BE371A51908393A47B6E69E75B80CA9017E12CDCE87A67FC811BD58D6437657B'),
      beneficiaryAddress: Address('TCGJD3C6PGBW3UOFJHR2VLVM7UBPNGRWJ6AJXMQ'),
      feeMultiplier: BlockFeeMultiplier(0),
      votingEligibleAccountsCount: 14,
      harvestingEligibleAccountsCount: 479,
      totalVotingBalance: Amount(116887594468987),
      previousImportanceBlockHash: Hash256('77C5CD0D6B7BD6A0E62FC3910A13D764848C5DCECF176E04FA700E033F045753'),
      transactions: [
        AggregateBondedTransactionV1(
          network: NetworkType.TESTNET,
          transactions: [
            EmbeddedTransferTransactionV1(
              network: NetworkType.TESTNET,
              recipientAddress: UnresolvedAddress('TCIFSMQZAX3IDPHUP2RTXP26N6BJRNKEBBKP33I'),
              mosaics: [
                UnresolvedMosaic(
                  mosaicId: UnresolvedMosaicId(6300565133566699912),
                  amount: Amount(100)
                ),
              ],
            ),
            EmbeddedMosaicSupplyChangeTransactionV1(
              network: NetworkType.TESTNET,
              mosaicId: UnresolvedMosaicId(12342763262823),
              action: MosaicSupplyChangeAction.INCREASE,
              delta: Amount(11),
            ),
          ],
          signerPublicKey: PublicKey('3BB09D6DA59708F9D93C9B4AB8AE5DCB826A6412D740CCD038D50CEF6E52EB3B'),
          signature: Signature('779F663E37728DE17E16085C753D8831BFE65380936F7233BF3D38986803361003B840B68A899CEBF651A5F5DE0E4AE1E992C3E94234A9903DBE155814426A6A'),
          fee: Amount('18370164183782063840'),
          deadline: Timestamp(8207562320463688160),
          cosignatures: [
            Cosignature(
              signerPublicKey: PublicKey('94873eeeea7e7b71a0755484aef901805c8aafa96cfd36bfc8827d52f0d1f174'),
              signature: Signature('84eb28ba49df25ea464a9fb02327c508be0e982a15ccc4dbc93f3216de3c9500016ad0960cd98904fdee031da15ea683a65016f5e94fb742590b71f23ee56d2e')
            ),
            Cosignature(
              signerPublicKey: PublicKey('78c8b3878d40d868195b1ddaa5dfaa5a784878f5fa1f24f7def27213f2f727a0'),
              signature: Signature('dd4e615209bc6b8b3d204ffb17f80a08f4ba3891fad9bf1eecf336e659091c0e8cdff802555e2daf19a3a7706abf4f9cc7406d4cf5fac3cc5bbdf72d4e7a1808')
            )
          ],
          transactionsHash: Hash256('D888625D77638015FA727BDCCCDC8CEE715CBAF7804F9F39EDC6DFE8536FEB1E')
        ),
        TransferTransactionV1(
          network: NetworkType.TESTNET,
          recipientAddress: UnresolvedAddress('TBA6LOHEA6A465G2X5MSQF66JBYR254GJDPK7MQ'),
          mosaics: [
            UnresolvedMosaic(
              mosaicId: UnresolvedMosaicId(12342763262823),
              amount: Amount(300)
            ),
            UnresolvedMosaic(
              mosaicId: UnresolvedMosaicId(95442763262823),
              amount: Amount(100)
            ),
          ],
          message: utf8ToBytes('Hello \ud83d\udc4b'),
          signerPublicKey: PublicKey('3BB09D6DA59708F9D93C9B4AB8AE5DCB826A6412D740CCD038D50CEF6E52EB3B'),
          signature: Signature('779F663E37728DE17E16085C753D8831BFE65380936F7233BF3D38986803361003B840B68A899CEBF651A5F5DE0E4AE1E992C3E94234A9903DBE155814426A6A'),
          fee: Amount('18370164183782063840'),
          deadline: Timestamp(8207562320463688160)
        )
      ],
      signature: Signature('779F663E37728DE17E16085C753D8831BFE65380936F7233BF3D38986803361003B840B68A899CEBF651A5F5DE0E4AE1E992C3E94234A9903DBE155814426A6A'),
      signerPublicKey: PublicKey('3bb09d6da59708f9d93c9b4ab8ae5dcb826a6412d740ccd038d50cef6e52eb3b'),
      timestamp: Timestamp(8207562320463688160)
      );
    expect(bytesToHex(block.serialize()), payload);
    BlockFactory().deserialize(payload);
    //expect(bytesToHex((BlockFactory().deserialize(payload) as StructBase).serialize()), payload);
  });
}
void main() async {
  blocksTest();
}

