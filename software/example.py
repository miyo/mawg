#!/usr/bin/env python
# coding: utf-8

# In[208]:


from pynq import Overlay
from pynq import MMIO


# In[209]:


base = Overlay("./top.bit")


# In[210]:


import utils
import ad3542_utils


# In[303]:


import importlib
importlib.reload(utils)
importlib.reload(ad3542_utils)


# In[212]:


d = utils.open_data_file("./Vset_sample.txt")


# In[213]:


utils.validate_data(d)


# In[214]:


v = ad3542_utils.to_hex(0)
print("{0:0>4x}".format(v))


# In[215]:


v = ad3542_utils.to_value(0xFFF0)
print(v)


# In[216]:


wave_data = MMIO(base_addr = 0x40000000, length = 0x10000, debug = True)
ctrl_data = MMIO(base_addr = 0x42000000, length = 0x10000, debug = True)
gpio = MMIO(base_addr = 0x41200000, length = 0x10000, debug = True)


# In[217]:


ad3542_utils.write_wave_data(wave_data, 0, 0, 0x8000)


# In[223]:


for ch in range(17):
    for i in range(128):
        ad3542_utils.write_wave_data(wave_data, ch, i, 0x8000+i)


# In[305]:


data_num = len(d[0])
ad3542_utils.write_ctrl_data(ctrl_data, data_num=data_num, repetition=1000000, wait_num=2**24)


# In[306]:


ad3542_utils.sequencer_kick(gpio)


# In[311]:


"{0:0>8x}".format(ad3542_utils.get_sequencer_status(gpio))


# In[310]:


ad3542_utils.sequencer_force_stop(gpio)


# In[312]:


ad3542_utils.set_trigger(wave_data, d[0])


# In[313]:


ad3542_utils.set_waveform(wave_data, d[1:])


# In[314]:


data_num = len(d[0])
ad3542_utils.write_ctrl_data(ctrl_data, data_num=data_num, repetition=1000000, wait_num=2)


# In[317]:


ad3542_utils.sequencer_kick(gpio)


# In[318]:


"{0:0>8x}".format(ad3542_utils.get_sequencer_status(gpio))


# In[ ]:


ad3542_utils.sequencer_force_stop(gpio)

