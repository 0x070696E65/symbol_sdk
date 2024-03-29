using System.Security.Cryptography;

namespace SymbolSdk;
/**
 *  Represents a private key.
 */
public class PrivateKey : ByteArray {
    public const byte SIZE = 32;

    /**
	 * Creates a private key from bytes or a hex string.
	 * @param {byte[]|string} privateKey Input string or byte array.
	 */
    public PrivateKey(object privateKey): base(SIZE, privateKey) {
    }

    /**
	 * Creates a random private key.
	 * @returns {PrivateKey} Random private key.
	 */
    public static PrivateKey Random()
    {
        var rng = new RNGCryptoServiceProvider();
        var random = new byte[SIZE];
        rng.GetBytes(random);
        return new PrivateKey(random);
    }
}

public class SharedKey256 : ByteArray {
	public const byte SIZE = 32;
	public SharedKey256(object privateKey): base(SIZE, privateKey) {
	}
}
