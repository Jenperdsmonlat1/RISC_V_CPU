import cocotb
from cocotb.triggers import Timer, FallingEdge, RisingEdge


instructions = [0x00000013, 0x00100093, 0x00200113, 0x00308193]
expected_result = [
    [0x13, 0x00, 0x00, 0x00, 0x00],
    [0x13, 0x01, 0x00, 0x00, 0x01],
    [0x13, 0x02, 0x00, 0x00, 0x02],
    [0x13, 0x03, 0x00, 0x01, 0x03]]

async def generate_clock(dut):

    while True:
        dut.clk.value = 0
        await Timer(5, unit="ns")
        dut.clk.value = 1
        await Timer(5, unit="ns")

def r_to_i(funct7: int, rs2: int) -> int:
    
    return (funct7 << 5) | rs2

@cocotb.test()
async def ir_test(dut):

    cocotb.start_soon(generate_clock(dut))

    dut.rst.value = 1
    dut.instruction.value = 0
    await Timer(15, unit="ns")
    await RisingEdge(dut.clk)
    dut.rst.value = 0

    cocotb.log.info("Test bloc instruction register.")
    for i in range(4):
        
        dut.instruction.value = instructions[i]
        await RisingEdge(dut.clk)
        await Timer(15, unit="ns")
        print(dut.opcode.value, dut.rd.value, dut.funct3.value, dut.rs1.value, dut.funct7.value, dut.rs2.value)
        assert int(dut.opcode.value) == expected_result[i][0] and int(dut.rd.value) == expected_result[i][1] and int(dut.funct3.value) == expected_result[i][2] and int(dut.rs1.value) == expected_result[i][3] and r_to_i(int(dut.funct7.value), int(dut.rs2.value)) == expected_result[i][4], f"Erreur: Attendu: {expected_result[i][0], expected_result[i][1], expected_result[i][2], expected_result[i][3], expected_result[i][4]}, Obtenu: {dut.opcode.value, dut.rd.value, dut.funct3.value, dut.rs1.value, r_to_i(int(dut.funct7.value), int(dut.rs2.value))}"
    
    cocotb.log.info("Test terminé.");