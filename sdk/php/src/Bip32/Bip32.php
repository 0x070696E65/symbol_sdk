<?php
namespace SymbolSdk\Bip32;

use SymbolSdk\Bip32\Bip32Node;
use SymbolSdk\BIP39\BIP39;
use SymbolSdk\BIP39\BIP39JapaneseWordList;
use SymbolSdk\BIP39\BIP39EnglishWordList;

class Bip32 {
	private string $_rootHmacKey;
	private string $_mnemonicLanguage;

	public function __construct($curveName = 'ed25519', $mnemonicLanguage = 'english')
	{
		$this->_rootHmacKey = mb_convert_encoding($curveName . ' seed', 'ISO-8859-1', 'UTF-8');
		$this->_mnemonicLanguage = $mnemonicLanguage;
	}

	public function fromSeed(string $seed){
		return new Bip32Node($this->_rootHmacKey, $seed);
	}

	public function fromMnemonic(string $mnemonic, string $password){
		$seedHex = BIP39::mnemonicToSeedHex($mnemonic, $password);
		return $this->fromSeed(hex2bin($seedHex));
	}

	public function random($seedLength = 32) {
		return Bip39::entropyToMnemonic(BIP39::generateEntropy($seedLength * 8), self::createWordList($this->_mnemonicLanguage));
	}

	private static function createWordList($mnemonicLanguage) {
		switch ($mnemonicLanguage) {
			case 'english':
				return new BIP39EnglishWordList();
			case 'japanese':
				return new BIP39JapaneseWordList();
			default:
				return new BIP39EnglishWordList();
		}
	}
}