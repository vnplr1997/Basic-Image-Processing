import numpy as np
import skimage.io
import matplotlib.pyplot as pyplot
from pathlib import Path


def histequal(image):

    [m,n]=np.shape(image)
    freq,bins=np.histogram(image,bins=256,range=(0,1))
    prob=freq*(1/(m*n))
    cumul=np.zeros(np.size(prob))

    for i in range(np.size(prob)):
        cumul[i]=np.sum(prob[0:i+1])

    J=np.zeros((m,n))
    
    for i in range(m):
        for j in range(n):
            J[i,j]=cumul[int(255*image[i,j])]
    
    return J  

def plothist(image,J):
    
    freq,bins=np.histogram(image,bins=256)
    aa=np.arange(256)
    freq2,bins=np.histogram(J,bins=256)
    
    pyplot.subplot(121)
    pyplot.plot(aa,freq)
    pyplot.title('Histogram of Original Image')
    pyplot.subplot(122)    
    pyplot.plot(aa,freq2)
    pyplot.title('Histogram of HE Image')

    
def plotimage(image,J):
    
    pyplot.subplot(121)
    pyplot.imshow(image, cmap='gray')
    pyplot.title('Original Image')
    pyplot.subplot(122)    
    pyplot.imshow(J,cmap='gray')
    pyplot.title('Histogram Equalized Image')
    
    
def main():
    image_path = Path('../Data/LowLight_2.png')
    image=skimage.io.imread(image_path)
    image=image.astype('double')/255
    J=histequal(image)
    
    plotimage(image,J)
   #plothist(image,J)
    pyplot.show()
    

main()
