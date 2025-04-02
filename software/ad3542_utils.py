def to_hex(value):
    v = value + 10.0
    h = int(v / (20.0 / (2**12)))
    if h >= 2**12:
        h = 2**12-1
    if h < 0:
        h = 0
    return (h << 4)

def to_value(h):
    v = (h >> 4) * (20.0 / (2**12))
    return (v - 10.0)

def write_wave_data(mmio, ch, index, value):
    mmio.write(((ch<<9)+index)<<2, value)

def write_ctrl_data(mmio, data_num, repetition, wait_num):
    value = (data_num&0x1FF)+((repetition&0x7FFFFF)<<9)
    print("mawg_ctrl_value[31:0]: {0:0>8x}".format(value))
    mmio.write(0, value);
    value = (wait_num&0xFFFFFFFF)
    print("mawg_ctrl_value[63:32]: {0:0>8x}".format(value))
    mmio.write(4, value);

def sequencer_kick(gpio):
    gpio.write(0, 0)
    gpio.write(0, 1)
    gpio.write(0, 0)

def sequencer_force_stop(gpio):
    gpio.write(0, 2)
    gpio.write(0, 0)

def set_waveform(mmio, waveforms):
    # set wave data
    for ch, values in enumerate(waveforms):
        for i, v in enumerate(values):
            write_wave_data(mmio, ch, i, to_hex(v))

def set_trigger(mmio, seq):
    # set tigger data
    TRIGGER_CH = 16
    for i, v in enumerate(seq):
        write_wave_data(mmio, TRIGGER_CH, i, int(v))

def get_sequencer_status(gpio):
    return gpio.read(8)

