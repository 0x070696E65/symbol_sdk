import "mosaic.cats"
import "transaction.cats"

# enumeration of mosaic supply change actions
enum MosaicSupplyChangeAction : uint32
	# increases the supply
	INCREASE = 0x01

	# decreases the supply
	DECREASE = 0x02

# shared content between verifiable and non-verifiable mosaic supply change transactions
struct MosaicSupplyChangeTransactionBody
	TRANSACTION_VERSION = make_const(uint8, 1)
	TRANSACTION_TYPE = make_const(TransactionType, MOSAIC_SUPPLY_CHANGE)

	# mosaic id size
	mosaic_id_size = sizeof(uint32, mosaic_id)

	# mosaic id
	mosaic_id = MosaicId

	# supply change action
	action = MosaicSupplyChangeAction

	# change amount
	delta = Amount

# binary layout for a mosaic supply change transaction
struct MosaicSupplyChangeTransaction
	inline Transaction
	inline MosaicSupplyChangeTransactionBody

# binary layout for a non-verifiable mosaic supply change transaction
struct NonVerifiableMosaicSupplyChangeTransaction
	inline NonVerifiableTransaction
	inline MosaicSupplyChangeTransactionBody