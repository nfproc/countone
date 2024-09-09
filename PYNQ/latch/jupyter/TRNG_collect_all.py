# TRNG Data Collection

from pynq import DefaultIP
from pynq import Overlay
from pynq import allocate
import numpy as np
import time

class TRNGCore(DefaultIP):
    ADDR_GO         = 0x00
    ADDR_STOP       = 0x00
    ADDR_RUN        = 0x00
    ADDR_OVER       = 0x00
    MASK_RUN        = 0x1
    MASK_OVER       = 0x2
    ADDR_SEND_BYTES = 0x04
    ADDR_SENT_BYTES = 0x04
    ADDR_DMA_BYTES  = 0x08
    ADDR_SUM_DATA   = 0x08
    ADDR_PARAMETER  = 0x0c
    ADDR_STATS      = 0x0c
    send_bytes = 0
    
    def __init__(self, description):
        super().__init__(description=description)
        self.stop()
        
    bindto = ['xilinx.com:user:TRNG_IP:1.0']
    
    def start (self, total, dma_size = 4096):
        self.write(self.ADDR_SEND_BYTES, total)
        self.write(self.ADDR_DMA_BYTES, dma_size)
        self.write(self.ADDR_GO, 1)
        self.send_bytes = total
    
    def wait (self):
        if self.send_bytes != 0:
            while True:
                if (self.read(self.ADDR_RUN) & self.MASK_RUN) == 0:
                    break
        if (self.read(self.ADDR_OVER) & self.MASK_OVER) != 0:
            raise OSError("TRNG Buffer Overflow")
        
    def stop (self):
        self.write(self.ADDR_STOP, 0)
    
    parameter = property()
    @parameter.setter
    def parameter(self, value):
        self.write(self.ADDR_PARAMETER, value)
    
    @property
    def sent_bytes(self):
        return self.read(self.ADDR_SENT_BYTES)
    
    @property
    def sum_data(self):
        return self.read(self.ADDR_SUM_DATA)
    
    @property
    def user_stats(self):
        return self.read(self.ADDR_STATS)

def dma_wait(rng, channel):
    while True:
        if rng.user_stats == 31:
            print("!! Online test cannot be passed. Stop.")
            return False
        if channel.error:
            print("!! DMA error occurred. Stop.")
            return False
        if channel.idle:
            channel.wait()
            return True

def collect_random(num_latch, margin, freq_enable):
    BLOCK_SIZE = 4096 # in Byte (32,768 bits)
    NUM_BLOCKS = 30518 # x 32,768 = 1,000,013,824 bits 

    FILE_PREFIX = "freqC"
    if freq_enable == 0:
        FILE_PREFIX = "no" + FILE_PREFIX

    pl = Overlay("latch%02d.bit" % num_latch)
    rng = pl.TRNG_IP_0
    dma = pl.axi_dma_0
    buffer_r = allocate(shape=(BLOCK_SIZE // 4,), dtype=np.uint32)
    buffer_w = allocate(shape=(BLOCK_SIZE // 4,), dtype=np.uint32)
    file = open("%s%02d_%d.dat" % (FILE_PREFIX, num_latch, margin), "wb")
    log = open("log_%s%02d_%d.txt" % (FILE_PREFIX, num_latch, margin), "w")

    rng.parameter = 9 + margin * 0x100 + freq_enable * 0x10000
    rng.start(NUM_BLOCKS * BLOCK_SIZE)
    transferred = 0
    start = time.time()

    for i in range(NUM_BLOCKS):
        dma.recvchannel.transfer(buffer_r)
        if i != 0:
            buffer_w.tofile(file)
        if not dma_wait(rng, dma.recvchannel):
            break
        print(rng.user_stats + 1, file=log)
        buffer_r, buffer_w = buffer_w, buffer_r
        transferred += 1

    elapsed = time.time() - start
    print(f"Elapsed Time: {elapsed} sec.", file=log)
    throughput = BLOCK_SIZE * transferred / elapsed / 125000
    print(f"Throughput: {throughput} Mbit/sec.", file=log)

    rng.stop()
    if transferred == NUM_BLOCKS:
        buffer_w.tofile(file)
    file.close()
    log.close()
    buffer_r.freebuffer()
    buffer_w.freebuffer()

for l in (8, 16, 32, 64):
    for a in (1, 2, 3):
        collect_random(l, a, 1)
    for a in (1, 2, 3):
        collect_random(l, a, 0)
