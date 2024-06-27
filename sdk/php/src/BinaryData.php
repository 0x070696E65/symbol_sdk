<?php

namespace SymbolSdk;

use SymbolSdk\Utils;

use Exception;
use RangeException;

/**
 * Represents a fixed size byte array.
 */
class BinaryData
{
	public $binaryData;

	/**
	 * Creates a byte array.
	 * @param int fixedSize Size of the array.
	 * @param string hex string.
	 */
	public function __construct($fixedSize, $binaryData)
	{
		if (Utils\isHexString($binaryData)) {
			$binaryData = hex2bin($binaryData);
		} else {
			try {
				$binaryData = Utils\addressToBinary($binaryData);
			} catch (Exception $e) {
				// Not in address format; ignoring without error.
			}
		}
		if ($fixedSize !== strlen($binaryData))
			throw new RangeException("Bytes was size " . strlen($binaryData) . " but must be $fixedSize");

		$this->binaryData = $binaryData;
	}

	/**
	 * Returns string representation of this object.
	 * @return string String representation of this object
	 */
	public function __toString()
	{
		if (get_class($this) == 'SymbolSdk\Symbol\Address' || get_class($this) == 'SymbolSdk\Symbol\UnresolvedAddress') {
			return Utils\binaryToAddress($this->binaryData);
		}

		return '0x' . strtoupper(bin2hex($this->binaryData));
	}
}