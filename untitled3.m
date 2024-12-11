% Load the image from the provided path
img = imread('E:\mathlab\Cropped Faces\face_1.jpg');

% Convert the image to grayscale
gray_img = rgb2gray(img);



% Extract 59 features using Local Binary Pattern (LBP)
lbp_features = extractLBPFeatures(gray_img, 'NumNeighbors', 8, 'Radius', 1);

% Display the image with histogram
figure;
subplot(1, 2, 1);
imshow(gray_img);
title('Grayscale Image');
subplot(1, 2, 2);
bar(lbp_features);
title('LBP Histogram (59 features)');
xlabel('Feature Index');
ylabel('Feature Value');

% Print the extracted 59 features
disp(lbp_features);


% Compute the Local Binary Pattern (LBP) image
lbp_img = vl_lbp(single(gray_img), 8, 1);

% Display the images and histogram
figure;
subplot(2, 2, 1);
imshow(img);
title('Original Image');
subplot(2, 2, 2);
imshow(gray_img);
title('Grayscale Image');
subplot(2, 2, 3);
imshow(lbp_img, []);
title('Local Binary Pattern (LBP) Image');
subplot(2, 2, 4);
bar(lbp_features);
title('LBP Histogram (59 features)');
xlabel('Feature Index');
ylabel('Feature Value');

% Print the extracted 59 features
disp(lbp_features);
imshow(lbp_img);




