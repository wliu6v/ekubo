// use hash::{pedersen};
use starknet::{contract_address_const, ContractAddress};
use option::{Option, OptionTrait};
use traits::{Into, TryInto};
use hash::{LegacyHash};
use zeroable::{Zeroable};
use ekubo::types::i129::{i129};
use ekubo::types::bounds::{Bounds};

// Uniquely identifies a pool
// token0 is the token with the smaller address (sorted by integer value)
// token1 is the token with the larger address (sorted by integer value)
// fee is specified as a 0.128 number, so 1% == 2**128 / 100
// tick_spacing is the minimum spacing between initialized ticks, i.e. ticks that positions may use
// extension is the address of a contract that implements additional functionality for the pool
#[derive(Copy, Drop, Serde, PartialEq)]
struct PoolKey {
    token0: ContractAddress,
    token1: ContractAddress,
    fee: u128,
    tick_spacing: u128,
    extension: ContractAddress,
}


impl PoolKeyHash of LegacyHash<PoolKey> {
    fn hash(state: felt252, value: PoolKey) -> felt252 {
        // LegacyHash::hash(
        //     LegacyHash::hash(state, (value.token0, value.token1, value.fee, value.tick_spacing)),
        //     value.extension
        // )
        ''
    }
}

// salt is a random number specified by the owner to allow a single address to control many positions with the same pool and bounds
// owner is the immutable address of the position
// bounds is the price range where the liquidity of the position is active
#[derive(Copy, Drop, Serde, PartialEq)]
struct PositionKey {
    salt: u64,
    owner: ContractAddress,
    bounds: Bounds,
}

impl PositionKeyHash of LegacyHash<PositionKey> {
    fn hash(state: felt252, value: PositionKey) -> felt252 {
        // LegacyHash::hash(state, (value.salt, value.owner, value.bounds))
        ''
    }
}


// owner is the address that owns the saved balance
// token is the address of the token for which the balance is saved
// salt is a random number to allow a single address to own separate saved balances
#[derive(Copy, Drop, Serde, PartialEq)]
struct SavedBalanceKey {
    owner: ContractAddress,
    token: ContractAddress,
    salt: u64,
}

impl SavedBalanceKeyHash of LegacyHash<SavedBalanceKey> {
    fn hash(state: felt252, value: SavedBalanceKey) -> felt252 {
        LegacyHash::hash(state, (value.owner, value.token, value.salt))
    }
}
