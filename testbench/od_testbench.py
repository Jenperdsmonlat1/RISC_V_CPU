import cocotb
from cocotb.triggers import Timer, FallingEdge, RisingEdge


entry_list = [
    [0b0110011, 0b000, 0b0000000],
    [0b0110011, 0b000, 0b0100000],
    [0b0110011, 0b100, 0b0000000],
    [0b0110011, 0b110, 0b0000000],
    [0b0110011, 0b111, 0b0000000],
    [0b0110011, 0b001, 0b0000000],
    [0b0110011, 0b101, 0b0000000]]

expected_output = [
    [0b00001, 0, 0, 0, 0, 1, 0],
    [0b00010, 0, 0, 0, 0, 1, 0],
    [0b00011, 0, 0, 0, 0, 1, 0],
    [0b00100, 0, 0, 0, 0, 1, 0],
    [0b00101, 0, 0, 0, 0, 1, 0],
    [0b00110, 0, 0, 0, 0, 1, 0],
    [0b00111, 0, 0, 0, 0, 1, 0]]

async def generate_clock(dut):

    while True:
        dut.clk.value = 0
        await Timer(5, unit="ns")
        dut.clk.value = 1
        await Timer(5, unit="ns")


@cocotb.test()
async def ir_test(dut):

    cocotb.start_soon(generate_clock(dut))

    dut.rst.value = 1
    dut.opcode.value = 0
    dut.funct3.value = 0
    dut.funct7.value = 0
    await Timer(15, unit="ns")
    await RisingEdge(dut.clk)
    dut.rst.value = 0

    cocotb.log.info("Test bloc opcode decoder.")
    for i in range(7):
        
        dut.opcode.value = entry_list[i][0]
        dut.funct3.value = entry_list[i][1]
        dut.funct7.value = entry_list[i][2]
        await Timer(15, unit="ns")
        await RisingEdge(dut.clk)

        assert int(dut.alu_op.value) == expected_output[i][0] \
        and int(dut.alu_src.value) == expected_output[i][1] \
        and int(dut.mem_read.value) == expected_output[i][2] \
        and int(dut.mem_write.value) == expected_output[i][3] \
        and int(dut.mem_to_reg.value) == expected_output[i][4] \
        and int(dut.reg_write.value) == expected_output[i][5] \
        and int(dut.branch.value) == expected_output[i][6], \
        print(f"Error, expected_result: {expected_output[i][0], expected_output[i][1], expected_output[i][2], expected_output[i][3], expected_output[i][4], expected_output[i][5], expected_output[i][6]}")
    
    cocotb.log.info("Test terminé.")