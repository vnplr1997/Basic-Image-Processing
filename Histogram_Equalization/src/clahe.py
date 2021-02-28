import numpy as np
import skimage.io
import matplotlib.pyplot as plt
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

def histequall(freq,image):
    
    [m,n]=np.shape(image)
    prob=freq*(1/(m*n))
    cumul=np.zeros(np.size(prob))

    for i in range(np.size(prob)):
        cumul[i]=np.sum(prob[0:i+1])


    J=np.zeros((m,n))
    
    for i in range(m):
        for j in range(n):
            J[i,j]=cumul[int(255*image[i,j])]
    
    return J


        

def localhist(image): 

    [m,n]=np.shape(image)

    N1=int(m/8)
    N2=int(n/8)

    nhedge=int(np.ceil(m/N1))
    nvedge=int(np.ceil(n/N2))

    new_image=np.zeros((m,n))

    #hor_edge=[i*N for i in range(nhedge+1)]  
    #ver_edge=[i*N for i in range(nvedge+1)]

    for i in range(nhedge):
        for j in range(nvedge):
            
            temp_image=image[N1*i:N1*i+N1,N2*j:N2*j+N2]
            freq,bins=np.histogram(temp_image,bins=256,range=(0,1))
            new_freq=clipping(freq)
            
            new_temp_image=histequall(new_freq,temp_image)
            new_image[N1*i:N1*i+N1,N2*j:N2*j+N2]=new_temp_image

    return new_image

def localhistoverlap(image):
    
    [m,n]=np.shape(image)
    N1=int(m/8)
    N2=int(n/8)
    
    x=int(np.ceil(4*m/25))
    y=int(np.ceil(4*n/25))
    
    nhedge=8
    nvedge=8

    horinit_edge=[int(3*i*x/4) for i in range(nhedge+1)]
    horfin_edge=[int((3*i+4)*x/4) for i in range(nhedge+1)]

    verinit_edge=[int(3*i*y/4) for i in range(nvedge+1)]
    verfin_edge=[int((3*i+4)*y/4) for i in range(nvedge+1)]

    III=np.zeros((m,n,64))

    l=0
    for i in range(nhedge):
        for j in range(nvedge):  
                
            temp_image=image[horinit_edge[i]:horfin_edge[i],verinit_edge[j]:verfin_edge[j]]
            freq,bins=np.histogram(temp_image,bins=256,range=(0,1))
            new_freq=clipping(freq)

            new_temp_image=histequall(new_freq,temp_image)

            III[horinit_edge[i]:horfin_edge[i],verinit_edge[j]:verfin_edge[j],l]=new_temp_image

            l=l+1
    return III



    
def clipping(array):
    
    thre=np.max(array)/4
    new_array=np.zeros(np.size(array))
    new_array[array>=thre]=thre
    new_array[array<thre]=array[array<thre]
    
    s1=np.sum(array)
    s2=np.sum(array[array>=thre])
    i1=np.size(np.where(array>=thre))

    s3=i1*thre

    s4=s2-s3

    i2=np.size(np.nonzero(array))

    i3=i2-i1

    for i in range(np.size(array)):
        if array[i]!=0 and array[i]<thre:
            new_array[i]=array[i]+np.ceil(s4/i3)
            
    return new_array



def main():
    image_path = Path('../Data/StoneFace.png')
    image=skimage.io.imread(image_path)
    [m,n]=np.shape(image)
    image=image.astype('double')/255
    h=histequal(image)
    J=localhist(image)
    J2=localhistoverlap(image)
    J3=np.zeros(np.shape(image))
    
    for i in range(m):
        for j in range(n):
            
            J3[i,j]=np.sum(J2[i,j,:])/np.size(np.nonzero(J2[i,j,:]))
                
   
    

    plt.subplot(221)
    plt.imshow(image,cmap='gray')
    plt.title('Origianal Image')
    plt.axis('off')
    plt.subplot(222)  
    plt.imshow(h,cmap='gray')
    plt.title('Histogram Equalized')
    plt.axis('off')
    plt.subplot(223)
    plt.imshow(J,cmap='gray')
    plt.title('CLAHE')
    plt.axis('off')
    plt.subplot(224)  
    plt.imshow(J3,cmap='gray')
    plt.title('CLAHE with Overlap')
    plt.axis('off')
    plt.show()

main()
