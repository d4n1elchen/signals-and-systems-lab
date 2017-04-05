import numpy as np
from scipy.io import wavfile
fs, src = wavfile.read('clean.wav')
upperbound = 0.05 * 32767
lowerbound = -0.05 * 32767
src = np.where(src > upperbound, upperbound, src)
src = np.where(src < lowerbound, lowerbound, src)
src = src.astype('int16')
wavfile.write('distortion.wav', fs, src)
