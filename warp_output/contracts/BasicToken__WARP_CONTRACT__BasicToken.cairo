%lang starknet

from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from warplib.maths.neq import warp_neq
from warplib.maths.sub import warp_sub256
from warplib.maths.add import warp_add256

func WS0_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(
    loc : felt
) -> (val : Uint256):
    alloc_locals
    let (read0) = WARP_STORAGE.read(loc)
    let (read1) = WARP_STORAGE.read(loc + 1)
    return (Uint256(low=read0, high=read1))
end

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(
    loc : felt, value : Uint256
) -> (res : Uint256):
    WARP_STORAGE.write(loc, value.low)
    WARP_STORAGE.write(loc + 1, value.high)
    return (value)
end

@storage_var
func WARP_MAPPING0(name : felt, index : felt) -> (resLoc : felt):
end
func WS0_INDEX_felt_to_Uint256{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt
}(name : felt, index : felt) -> (res : felt):
    alloc_locals
    let (existing) = WARP_MAPPING0.read(name, index)
    if existing == 0:
        let (used) = WARP_USED_STORAGE.read()
        WARP_USED_STORAGE.write(used + 2)
        WARP_MAPPING0.write(name, index, used)
        return (used)
    else:
        return (existing)
    end
end

# Contract Def BasicToken

@storage_var
func WARP_STORAGE(index : felt) -> (val : felt):
end
@storage_var
func WARP_USED_STORAGE() -> (val : felt):
end
@storage_var
func WARP_NAMEGEN() -> (name : felt):
end
func readId{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(
    loc : felt
) -> (val : felt):
    alloc_locals
    let (id) = WARP_STORAGE.read(loc)
    if id == 0:
        let (id) = WARP_NAMEGEN.read()
        WARP_NAMEGEN.write(id + 1)
        WARP_STORAGE.write(loc, id + 1)
        return (id + 1)
    else:
        return (id)
    end
end

namespace BasicToken:
    # Dynamic variables - Arrays and Maps

    const __warp_usrid1_balances = 1

    # Static variables

    const __warp_usrid0_totalSupply_ = 0

    const __warp_usrid2_initialSupply = 3

    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(
        __warp_usrid3_initialSup : Uint256
    ):
        alloc_locals
        WARP_USED_STORAGE.write(5)
        WARP_NAMEGEN.write(1)

        warp_external_input_check_int256(__warp_usrid3_initialSup)

        WS_WRITE0(__warp_usrid2_initialSupply, Uint256(low=1000, high=0))

        WS_WRITE0(__warp_usrid0_totalSupply_, __warp_usrid3_initialSup)

        let (__warp_se_0) = get_caller_address()

        let (__warp_se_1) = WS0_INDEX_felt_to_Uint256(__warp_usrid1_balances, __warp_se_0)

        WS_WRITE0(__warp_se_1, __warp_usrid3_initialSup)

        return ()
    end

    @view
    func totalSupply_18160ddd{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt
    }() -> (__warp_usrid4_ : Uint256):
        alloc_locals

        let (__warp_se_2) = WS0_READ_Uint256(__warp_usrid0_totalSupply_)

        return (__warp_se_2)
    end

    @external
    func transfer_a9059cbb{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr : felt,
        bitwise_ptr : BitwiseBuiltin*,
    }(__warp_usrid5__to : felt, __warp_usrid6__value : Uint256) -> (__warp_usrid7_ : felt):
        alloc_locals

        warp_external_input_check_int256(__warp_usrid6__value)

        warp_external_input_check_address(__warp_usrid5__to)

        let (__warp_se_3) = warp_neq(__warp_usrid5__to, 0)

        assert __warp_se_3 = 1

        let (__warp_se_4) = get_caller_address()

        let (__warp_se_5) = WS0_INDEX_felt_to_Uint256(__warp_usrid1_balances, __warp_se_4)

        let (__warp_se_6) = get_caller_address()

        let (__warp_se_7) = WS0_INDEX_felt_to_Uint256(__warp_usrid1_balances, __warp_se_6)

        let (__warp_se_8) = WS0_READ_Uint256(__warp_se_7)

        let (__warp_se_9) = warp_sub256(__warp_se_8, __warp_usrid6__value)

        WS_WRITE0(__warp_se_5, __warp_se_9)

        let (__warp_se_10) = WS0_INDEX_felt_to_Uint256(__warp_usrid1_balances, __warp_usrid5__to)

        let (__warp_se_11) = WS0_INDEX_felt_to_Uint256(__warp_usrid1_balances, __warp_usrid5__to)

        let (__warp_se_12) = WS0_READ_Uint256(__warp_se_11)

        let (__warp_se_13) = warp_add256(__warp_se_12, __warp_usrid6__value)

        WS_WRITE0(__warp_se_10, __warp_se_13)

        return (1)
    end

    @view
    func balanceOf_70a08231{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt
    }(__warp_usrid8__owner : felt) -> (__warp_usrid9_ : Uint256):
        alloc_locals

        warp_external_input_check_address(__warp_usrid8__owner)

        let (__warp_se_14) = WS0_INDEX_felt_to_Uint256(__warp_usrid1_balances, __warp_usrid8__owner)

        let (__warp_se_15) = WS0_READ_Uint256(__warp_se_14)

        return (__warp_se_15)
    end
end

# Original soldity abi: ["constructor(uint256)","","totalSupply()","transfer(address,uint256)","balanceOf(address)"]
