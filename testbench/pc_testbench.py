# pc_testbench.py
import cocotb
from cocotb.triggers import Timer, FallingEdge, RisingEdge


async def generate_clock(dut):

    while True:
        dut.clk.value = 0
        await Timer(5, unit="ns")
        dut.clk.value = 1
        await Timer(5, unit="ns")


@cocotb.test()
async def pc_test(dut):

    cocotb.start_soon(generate_clock(dut))

    dut.rst.value = 1
    dut.load.value = 0
    dut.next_pc.value = 0
    await Timer(15, unit="ns")
    await RisingEdge(dut.clk)
    dut.rst.value = 0

    cocotb.log.info("Test compteur normal")
    for i in range(10):
        await RisingEdge(dut.clk)
        expected = i * 4
        assert int(dut.pc_out.value) == expected, f"Erreur: attendu {expected}"
    
    cocotb.log.info("Test saut avec load=1")
    dut.load.value = 1
    dut.next_pc.value = 150
    await Timer(15, unit="ns")
    await RisingEdge(dut.clk)
    dut.load.value = 0
    assert int(dut.pc_out.value) == 150, f"[LOAD]: Expected: 150, obtenu: {int(dut.pc_out.value)}"

    cocotb.log.info("Test reprise après le saut")
    await Timer(15, unit="ns")
    await RisingEdge(dut.clk)
    assert int(dut.pc_out.value) == 154, f"[POST_LOAD] Erreur: Expected: 104, obtenu: {int(dut.pc_out.value)}"

    cocotb.log.info("Test reset")
    dut.rst.value = 1
    await Timer(15, unit="ns")
    await RisingEdge(dut.clk)
    dut.rst.value = 0

    assert int(dut.pc_out.value) == 0, f"[RESET]: Expected: 0, obtenu: {int(dut.pc_out.value)}"

    cocotb.log.info("Test réussis.")