# -*- coding: utf-8 -*-
"""
Created on Thu Jan 19 11:18:25 2017

@author: screamaudio Yen-Kuang
"""
#具備四個回授路徑的殘響產生器。準備不同獨奏音樂一分鐘音檔兩個。
#use python3
import numpy as np
#import wave
import scipy.io.wavfile
from scipy.ndimage.interpolation import shift

FSample, samples = scipy.io.wavfile.read("2.wav")
samples = samples[:,0]
length = (len(samples))

multiple = 6
delay = 4410 * multiple #0.1s * miltiple

q = np.matrix('1 0 0;0 1 0;0 0 1')

#after q matrix
g1 = 0.5
g2 = 0.5
g3 = 0.5

#before filter
c1 = 0.3
c2 = 0.09
c3 = 0.027

#before cycle
b1 = 1
b2 = 1
b3 = 1

#M1 M2 M3
delayNum1 = 1
delayNum2 = 3
delayNum3 = 5

d = 0.5

cycle = 5

#direct signal
direct = np.zeros(length+delay*delayNum3*cycle,dtype=np.int16)
direct[0:length] = samples

#initial output
y = np.zeros(length+delay*delayNum3*cycle,dtype=np.int16)

#get first cycle input
x1 = b1 * direct
x2 = b2 * direct
x3 = b3 * direct

#i=0:1:3
for i in range(0, 3, 1): #range(start, stop, tetp)
    y1 = shift(x1, delay*delayNum1, cval=0)
    y2 = shift(x2, delay*delayNum2, cval=0)
    y3 = shift(x3, delay*delayNum3, cval=0)

    #y[n] = y[n-1] + c*yq
    y = y + c1 * y1 + c2 * y2 + c3 * y3

    #yq: [y1 y2 y3]
    yq = np.zeros((length+delay*delayNum3*cycle,3),dtype=np.int16)
    yq[:,0] = y1
    yq[:,1] = y2
    yq[:,2] = y3

    #yr: feedback signal
    yr = yq * q
    yr[:,0] = g1 * yr[:,0]
    yr[:,1] = g2 * yr[:,1]
    yr[:,2] = g3 * yr[:,2]

    #x[n] = x[n-1] + yr
    for j in range(0,length+delay*delayNum3*cycle,1):
        x1[j] = x1[j] + yr[j,0]
        x2[j] = x2[j] + yr[j,1]
        x3[j] = x3[j] + yr[j,2]

#last output without feedback
y1 = shift(x1, delay*delayNum1, cval=0)
y2 = shift(x2, delay*delayNum2, cval=0)
y3 = shift(x3, delay*delayNum3, cval=0)

y = y + c1 * y1 + c2 * y2 + c3 * y3

yout = y + d * direct

yout = yout.astype('int16')
scipy.io.wavfile.write("yout.wav", FSample, yout)
