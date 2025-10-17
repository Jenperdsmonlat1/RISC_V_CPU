import cocotb
from cocotb.triggers import Timer, FallingEdge, RisingEdge


async def generate_clock(dut):

    while True:
        dut.clk.value = 0
        await Timer(5, unit="ns")
        dut.clk.value = 1
        await Timer(5, unit="ns")


@cocotb.test()
async def if_test(dut):

    cocotb.start_soon(generate_clock(dut))

    expected_instruction = [0x00000013, 0x00100093, 0x00200113, 0x00308193]

    dut.rst.value = 1
    dut.pc_address.value = 0
    await Timer(15, unit="ns")
    await RisingEdge(dut.clk)
    dut.rst.value = 0

    cocotb.log.info("Test du bloc instruction memory.")
    for i in range(4):
        dut.pc_address.value = i * 4
        await RisingEdge(dut.clk)
        await Timer(15, unit="ns")
        expected_ins = expected_instruction[i]
        expected_pc = i * 4
        print(dut.d_out.value)
        assert int(dut.pc_address.value) == expected_pc and int(dut.d_out.value) == expected_ins, f"Erreur: PC attendu: {expected_pc} Instruction attendu: {expected_ins}"

    cocotb.log.info("Test réussis.")

