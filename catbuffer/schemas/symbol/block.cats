import "transaction.cats"

using ProofGamma = binary_fixed(32)
using ProofVerificationHash = binary_fixed(16)
using ProofScalar = binary_fixed(32)

# enumeration of block types
enum BlockType : uint16
	# nemesis block
	NEMESIS = 0x8043

	# normal block
	NORMAL = 0x8143

	# importance block
	IMPORTANCE = 0x8243

# verfiable random function proof
struct VrfProof
	# gamma
	gamma = ProofGamma

	# verification hash
	verification_hash = ProofVerificationHash

	# scalar
	scalar = ProofScalar

# binary layout for a block header
inline struct BlockHeader
	inline SizePrefixedEntity
	inline VerifiableEntity
	inline EntityBody

	# block type
	type = BlockType

	# block height
	height = Height

	# number of milliseconds elapsed since creation of nemesis block
	timestamp = Timestamp

	# block difficulty
	difficulty = Difficulty

	# generation hash proof
	generation_hash_proof = VrfProof

	# previous block hash
	previous_block_hash = Hash256

	# hash of the transactions in this block
	transactions_hash = Hash256

	# hash of the receipts generated by this block
	receipts_hash = Hash256

	# hash of the global chain state at this block
	state_hash = Hash256

	# beneficiary address designated by harvester
	beneficiary_address = Address

	# fee multiplier applied to block transactions
	fee_multiplier = BlockFeeMultiplier

# binary layout for an importance block footer
inline struct ImportanceBlockFooter
	# number of voting eligible accounts
	voting_eligible_accounts_count = uint32

	# number of harvesting eligible accounts
	harvesting_eligible_accounts_count = uint64

	# total balance eligible for voting
	total_voting_balance = Amount

	# previous importance block hash
	previous_importance_block_hash = Hash256

# binary layout for a block
@size(size)
@initializes(version, BLOCK_VERSION)
@initializes(type, BLOCK_TYPE)
@discriminator(type)
@is_aligned
abstract struct Block
	inline BlockHeader

# binary layout for a nemesis block header
struct NemesisBlockV1
	BLOCK_VERSION = make_const(uint8, 1)
	BLOCK_TYPE = make_const(BlockType, NEMESIS)

	inline Block
	inline ImportanceBlockFooter

	# variable sized transaction data
	@alignment(8, not pad_last)
	transactions = array(Transaction, __FILL__)

# binary layout for a normal block header
struct NormalBlockV1
	BLOCK_VERSION = make_const(uint8, 1)
	BLOCK_TYPE = make_const(BlockType, NORMAL)

	inline Block

	# reserved padding to align end of BlockHeader on 8-byte boundary
	block_header_reserved_1 = make_reserved(uint32, 0)

	# variable sized transaction data
	@alignment(8, not pad_last)
	transactions = array(Transaction, __FILL__)

# binary layout for an importance block header
struct ImportanceBlockV1
	BLOCK_VERSION = make_const(uint8, 1)
	BLOCK_TYPE = make_const(BlockType, IMPORTANCE)

	inline Block
	inline ImportanceBlockFooter

	# variable sized transaction data
	@alignment(8, not pad_last)
	transactions = array(Transaction, __FILL__)
