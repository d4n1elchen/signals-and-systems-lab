import numpy as np
from scipy.io import wavfile
from scipy.signal import butter, lfilter

fs, src = wavfile.read('1.wav')
gain = [0.2, 0.5, 1.3, 1, 0.2, 0.3]
fc = [0.05, 0.2, 0.3, 0.4, 0.5]
N = 3 #order of the filter
y = [[],[],[],[],[],[]]
result = np.zeros(len(src))
for i in range(6):
    if i == 0:
        b, a = butter(N, fc[0], 'low')
        y[i] = lfilter(b, a, src)
    elif i == 5:
        b, a = butter(N, fc[4], 'high')
        y[i] = lfilter(b, a, src)
    else:
        b, a = butter(N, [fc[i-1], fc[i]], 'band')
        y[i] = lfilter(b, a, src)
    
    result = result + gain[i] * y[i]
result = result.astype('int16')
wavfile.write('result1.wav', fs, result)