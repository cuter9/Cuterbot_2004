#!/usr/bin/env python
#
# INA3221_jetbot
# Cuter Hsu
# 03/05/2024
#
#

# imports

import sys
import time
import datetime
# from jetbot.apps.ina3221 import INA3221
from jetbot.apps import INA3221

# Main Program

# filename = time.strftime("%Y-%m-%d%H:%M:%SRTCTest") + ".txt"
starttime = datetime.datetime.utcnow()

BOARD = 1
GPU = 2
CPU = 3
I2C_BUS = 6
I2C_ADDRESS = 0x40

ina3221 = INA3221(twi=I2C_BUS, addr=I2C_ADDRESS)

# the three channels of the INA3221 named for SunAirPlus Solar Power Controller channels (www.switchdoc.com)

def jetbot_pwr_states(channel=BOARD):

    shuntvoltage = 0
    busvoltage   = 0
    current_mA   = 0
    loadvoltage  = 0

    busvoltage = ina3221.getBusVoltage_V(channel)
    shuntvoltage = ina3221.getShuntVoltage_mV(channel)
  	# minus is to get the "sense" right.   - means the battery is charging, + that it is discharging
    current_mA = ina3221.getCurrent_mA(channel)

    loadvoltage = busvoltage + (shuntvoltage / 1000)
    
    return {"in_volt": loadvoltage, "in_current": current_mA, "shunt_volt": shuntvoltage, "end_volt": busvoltage}

'''
if __name__ == '__main__':
    pwr_state = jetbot_pwr_states()
    
    print("------------------------------")
    print("Bus Voltage: %3.2f V " % pwr_state["end_volt"])
    print("Shunt Voltage: %3.2f mV " % pwr_state["shunt_volt"])
    print("Load Voltage:  %3.2f V" % pwr_state["in_volt"])
    print("Current:  %3.2f mA" % pwr_state["in_current"])
    print()
'''
    