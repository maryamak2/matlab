clear all;
close all;
x=imread('image1.bmp'); %read the original img
r=im2double(x(:,:,1));
g=im2double(x(:,:,2));
b=im2double(x(:,:,3));
xx=cat(3,r,g,b);
%imshow(r or g or b); shows either the red or green or blue
cops
% devide images into 8x8 blocks as required
t=dctmtx(8);
dct=@(block_struct) t* block_struct.data *t';
%apply dct on each component
rdct=blockproc(r,[8,8],dct);
gdct=blockproc(g,[8,8],dct);
bdct=blockproc(b,[8,8],dct);
%mask formation according to m required m grid to slide on
image pixels
mask1=[1 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0];

 mask2=[1 1 0 0 0 0 0 0
 1 1 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0];

 mask3=[1 1 1 0 0 0 0 0
 1 1 1 0 0 0 0 0
 1 1 1 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0];

 mask4=[1 1 1 1 0 0 0 0
 1 1 1 1 0 0 0 0
 1 1 1 1 0 0 0 0
 1 1 1 1 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0];
%setting the window to operate on to get the right
compressed image size
%retaining only the needed components of image
rcmp1=blockproc(rdct,[8,8],@(block_struct)
block_struct.data(1:1,1:1));
gcmp1=blockproc(gdct,[8,8],@(block_struct)
block_struct.data(1:1,1:1));
bcmp1=blockproc(bdct,[8,8],@(block_struct)
block_struct.data(1:1,1:1));
cmp1=cat(3,rcmp1,gcmp1,bcmp1);%collect the compressed
colour components
rcmp2=blockproc(rdct,[8,8],@(block_struct)
block_struct.data(1:2,1:2));
gcmp2=blockproc(gdct,[8,8],@(block_struct)
block_struct.data(1:2,1:2));
bcmp2=blockproc(bdct,[8,8],@(block_struct)
block_struct.data(1:2,1:2));
cmp2=cat(3,rcmp2,gcmp2,bcmp2);
rcmp3=blockproc(rdct,[8,8],@(block_struct)
block_struct.data(1:3,1:3));
gcmp3=blockproc(gdct,[8,8],@(block_struct)
block_struct.data(1:3,1:3));
bcmp3=blockproc(bdct,[8,8],@(block_struct)
block_struct.data(1:3,1:3));
cmp3=cat(3,rcmp3,gcmp3,bcmp3);
rcmp4=blockproc(rdct,[8,8],@(block_struct)
block_struct.data(1:4,1:4));
gcmp4=blockproc(gdct,[8,8],@(block_struct)
block_struct.data(1:4,1:4));
bcmp4=blockproc(bdct,[8,8],@(block_struct)
block_struct.data(1:4,1:4));
cmp4=cat(3,rcmp4,gcmp4,bcmp4);
%apply masks on componets to get them decompressed
rm1=blockproc(rdct,[8,8],@(block_struct)
mask1.*block_struct.data);%red mask1
gm1=blockproc(gdct,[8,8],@(block_struct)
mask1.*block_struct.data);
bm1=blockproc(bdct,[8,8],@(block_struct)
mask1.*block_struct.data);
rm2=blockproc(rdct,[8,8],@(block_struct)
mask2.*block_struct.data);%red mask2
gm2=blockproc(gdct,[8,8],@(block_struct)
mask2.*block_struct.data);
bm2=blockproc(bdct,[8,8],@(block_struct)
mask2.*block_struct.data);
rm3=blockproc(rdct,[8,8],@(block_struct)
mask3.*block_struct.data);%red mask3
gm3=blockproc(gdct,[8,8],@(block_struct)
mask3.*block_struct.data);
bm3=blockproc(bdct,[8,8],@(block_struct)
mask3.*block_struct.data);
rm4=blockproc(rdct,[8,8],@(block_struct)
mask4.*block_struct.data);%red mask4
gm4=blockproc(gdct,[8,8],@(block_struct)
mask4.*block_struct.data);
bm4=blockproc(bdct,[8,8],@(block_struct)
mask4.*block_struct.data);
% inverse dct
inversion=@(block_struct) t' * block_struct.data *t;
ri1=blockproc(rm1,[8,8],inversion);
gi1=blockproc(gm1,[8,8],inversion);
bi1=blockproc(bm1,[8,8],inversion);
ri2=blockproc(rm2,[8,8],inversion);
gi2=blockproc(gm2,[8,8],inversion);
bi2=blockproc(bm2,[8,8],inversion);
ri3=blockproc(rm3,[8,8],inversion);
gi3=blockproc(gm3,[8,8],inversion);
bi3=blockproc(bm3,[8,8],inversion);
ri4=blockproc(rm4,[8,8],inversion);
gi4=blockproc(gm4,[8,8],inversion);
bi4=blockproc(bm4,[8,8],inversion);
%combination of RGB comps using the cat function
decompressed1_img=cat(3,ri1,gi1,bi1);
decompressed2_img=cat(3,ri2,gi2,bi2);
decompressed3_img=cat(3,ri3,gi3,bi3);
decompressed4_img=cat(3,ri4,gi4,bi4);
imwrite(x,'image1.bmp');
imwrite(r,'redoriginal.bmp');
imwrite(g,'greenoriginal.bmp');
imwrite(b,'blueoriginal.bmp');
imwrite(rdct,'reddct.bmp');
imwrite(gdct,'greendct.bmp');
imwrite(bdct,'bluedct.bmp');
imwrite(cmp1,'1stcompressed.bmp');
imwrite(cmp2,'2ndcompressed.bmp');
imwrite(cmp3,'3rdcompressed.bmp');
imwrite(cmp4,'4thcompressed.bmp');
imwrite(ri1,'rimask1.bmp');
imwrite(gi1,'gimask1.bmp');
imwrite(bi1,'bimask1.bmp');
imwrite(ri2,'rimask2.bmp');
imwrite(gi2,'gimask2.bmp');
imwrite(bi2,'bimask2.bmp');
imwrite(ri3,'rimask3.bmp');
imwrite(gi3,'gimask3.bmp');
imwrite(bi3,'bimask3.bmp');
imwrite(ri4,'rimask4.bmp');
imwrite(gi4,'gimask4.bmp');
imwrite(bi4,'bimask4.bmp');
imwrite(decompressed1_img,'decompressed1.bmp');
imwrite(decompressed2_img,'decompressed2.bmp');
imwrite(decompressed3_img,'decompressed3.bmp');
imwrite(decompressed4_img,'decompressed4.bmp');
[psnr1valu,snr1]=psnr(decompressed1_img,xx);
[psnr2valu,snr2]=psnr(decompressed2_img,xx);
[psnr3valu,snr3]=psnr(decompressed3_img,xx);
[psnr4valu,snr4]=psnr(decompressed4_img,xx);
psnrvalus =[psnr1valu psnr2valu psnr3valu psnr4valu];
plotpsnrs = [1 2 3 4 ];
plot(plotpsnrs,psnrvalus);
