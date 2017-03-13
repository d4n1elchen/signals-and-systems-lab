import numpy as np
from scipy.io import wavfile
from scipy.ndimage.interpolation import shift
src = []
for i in range(4):
	src.append([])
	fs, src[i] = wavfile.read('track'+str(i)+'.wav')
#
t = [0, 1, 13, 20]		#start time(sec)
l = [0.55, 0.6, 0.3, 0.3]	#left volumn
r = [0.4, 0.8, 0.5, 0.4]	#right volumn
left = np.zeros(len(src[0]))
right = np.zeros(len(src[0]))
for i in range(4):
	src[i] = shift(src[i], t[i]*fs, cval=0)
	left = left + src[i] * l[i]
	right = right + src[i] * r[i]
result = np.column_stack((left, right))
result = result.astype('int16')
wavfile.write('result.wav', fs, result)