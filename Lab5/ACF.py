# -*- coding: utf-8 -*-
"""
Created on Thu Jan 26 13:07:50 2017
#獨奏音樂之音高偵測(AMDF與Auto-correlation方法)。準備不同獨奏音樂一分鐘音檔兩個。
#ACF : Auto-Correlation Function
#use python3
@author: Lulu
"""
import numpy as np
import pylab as P
import math as m
import scipy.io.wavfile
from scipy.ndimage.interpolation import shift
FSample, samples = scipy.io.wavfile.read("01-1.wav")
samples = samples.astype(int)

length = (len(samples))

framesize = 1024
startFrame = 0
#frameNum = 1
frameNum = m.floor(length/framesize)

index = 0
Frame = np.zeros(framesize,dtype=np.int32)
ShiftFrame = np.zeros(framesize,dtype=np.int32)
acf = np.zeros(framesize,dtype=np.int32)
acfFinal = np.zeros(frameNum,dtype=np.int32)

i = 0
j = 0
index = 0

#autocorelation
for index in range(0,frameNum,1):
    Frame = samples[(startFrame+index)*framesize:(startFrame+index+1)*framesize]
    #Frame = samples[48000:48000+framesize]
    ShiftFrame = Frame
    acf = np.zeros(framesize,dtype=np.int32)
    for i in range(0,framesize,1):
        ShiftFrame = shift(Frame, i, cval=0)
        for j in range(i,framesize,1):
            acf[i] += Frame[j] * ShiftFrame[j]
    acf[0:5] = -10000000
    acfFinal[index] = np.argmax(acf)
            
        
print(acfFinal)
time = np.zeros(framesize,dtype=np.int16)
for a in range(0,framesize,1):
    time[a] = a

P.plot(time,acf)
P.xlabel('time (s)')
P.ylabel('acf')