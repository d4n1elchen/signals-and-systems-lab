# -*- coding: utf-8 -*-
"""
Created on Thu Mar  2 20:31:24 2017
HRTF function advanced
@author: Lulu
"""

import numpy as np
import pylab as P
import math as m
import scipy.io.wavfile
from scipy.ndimage.interpolation import shift
FSample, samples = scipy.io.wavfile.read("01-1.wav")
#FSample, samples = scipy.io.wavfile.read("_P.wav")

#samples = samples.astype(int)
#print (FSample)
#print (samples)
length = (len(samples))

sourceRadius = 300
headRadius = 8
angle = 0
elevation_angle = 0
e_angle = m.radians(elevation_angle)
rightangle = m.radians(angle)
leftangle = m.radians(180-angle)
R = ( (sourceRadius*m.sin(e_angle))**2 + (headRadius**2 + (sourceRadius*m.cos(e_angle))**2 - 2*headRadius*(sourceRadius*m.cos(e_angle))*m.cos(rightangle) ) )**0.5
L = ( (sourceRadius*m.sin(e_angle))**2 + (headRadius**2 + (sourceRadius*m.cos(e_angle))**2 - 2*headRadius*(sourceRadius*m.cos(e_angle))*m.cos(leftangle) ) )**0.5
RLdiff = R - L #如果大於0 表靠右耳近 反之
diff = round(abs(RLdiff))
diffsamplesNum = round(diff/34000 * 44100)

near = samples
#far = shift(right,diffsamplesNum)
far = shift(near,diffsamplesNum)

#final = samples + shiftSamples
final = np.zeros((len(samples),2),dtype=np.int16)
change = 1
if(RLdiff > 0):
    final[:,0] = far
    final[:,1] = near
elif(RLdiff < 0):
    final[:,0] = near
    final[:,1] = far
elif(RLdiff == 0):
    final = samples

print (samples)
print (final)
final = final.astype('int16')
scipy.io.wavfile.write("HRTFadv"+str(angle)+'e'+str(elevation_angle) +".wav", FSample, final)
