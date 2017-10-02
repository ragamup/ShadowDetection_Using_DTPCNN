% Author: Raghavender Muppavaram
%Last Modified 05/05/2017
clc;
clear all;
close all;
%Reading the image
I= im2double(imread('image.jpg'));
%Normalizing I
range = max(I(:)) - min(I(:));
I = (I- min(I(:))) / range;
range2 = 1 - 0.004;
I = (I * range2) + 0.004;
BW1=im2bw(I);
%Applying algorithm to R channel 
R=dtpcnn(I(:,:,1));
figure;
imshow(R);
%Applying algorithm to G channel
G=dtpcnn(I(:,:,2));
figure;
imshow(G);
%Applying algorithm to B channel
B=dtpcnn(I(:,:,3));
figure;
imshow(B);
Y=cat(3, R, G, B);
figure;
imshow(Y);
figure;
BW=imshow(im2bw(Y));
%Acuuracy
Input_Image = BW1>0;
test_Image = BW>0;
false_positives = ~Input_Image & test_Image;
false_positive_rate = sum(false_positives(:)) / numel(false_positives);
false_negatives = Input_Image & ~test_Image;
false_negative_rate = sum(false_negatives(:)) / numel(false_negatives);
true_positives = Input_Image & test_Image;
true_positive_rate = sum(true_positives(:)) / numel(true_positives);
true_negatives = ~Input_Image & ~test_Image;
true_negative_rate = sum(true_negatives(:)) / numel(true_negatives);
accuracy=(true_positive_rate+true_negative_rate)/(true_positive_rate+false_positive_rate+true_negative_rate+false_negative_rate);
fprintf('The accuracy for the image is:');
disp(accuracy);

%...................................END...............................%


