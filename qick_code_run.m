function [allFeatures,label,lbpImage,feature] =processImageFolder1(folderPath,val,allFeatures,label,tr)
    % Select a folder with UI
    if folderPath == 0
        disp('No folder selected, exiting.');
        return;
    end
    
    % Get all image files in the folder (assuming all files are images)
    imageFiles = dir(fullfile(folderPath, '*.jpg')); % Modify the extension as needed (e.g., *.png)
    
    numFiles = length(imageFiles);
    
    if numFiles == 0
        disp('No images found in the selected folder.');
        return;
    end
    feature=[];
    % Loop through each image in the folder
    for i = 1:numFiles
        % Read the image
        img = imread(fullfile(folderPath, imageFiles(i).name));
        row_sizes = [60 60 40];
        col_sizes = [60 60 40];
        C = mat2cell(img, row_sizes, col_sizes);
        [rows1, col1] = size(C);
        f=[];
        for h=1:rows1
            for q=1:col1
                m=cell2mat(C(h,q));
                lbpImage = LBPmanually(m);
                hist = histogram(lbpImage(:),59); % Use 59 bins for LBP features
                lbpHist=hist.Values;
                f=[f,lbpHist];
            end
        end
        % Compute the histogram of LBP features (59 possible values for LBP patterns)

        if tr==0
           feature=[feature;f];
        end
        
        % Append the histogram to the list
        if tr==1
            allFeatures = [allFeatures; f];
        end 
        %label
        if val>=0
            label=[label;val];
        end

    end
    % Optionally, save the results to a file (e.g., .mat file)
    %save('LBP_Features.mat', 'allFeatures');
    
    % Display a message that the processing is complete
    disp('Processing complete. LBP features extracted for all images.');
end
function [predict_label,cout,k,cout1]= testing_img(model,feature,t,b,cout,cout1)
    k=length(feature);
    predict_label=[];
    for i=1:k
       prediction=predict(model,feature(i,:));
       predict_label=[predict_label;prediction];
    end
    for i=1:k
       if predict_label(i)==t
           if b==1
              cout=cout+1;
           end
           if b==2
              cout1=cout1+1;
           end
       end
    end
end
function model=Training_img(allFeatures,label)
    model=fitcsvm(allFeatures,label);
end 

allFeatures = [];
label=[];
cout=0;
cout1=0;
val=1;
tr=1;
folderPath = uigetdir('E:\mathlab\NUAA Dataset\Training\train_real', 'Select Folder Containing Images');
[allFeatures,label,lbpImage]=processImageFolder1(folderPath,val,allFeatures,label,tr);
model=Training_img(allFeatures,label);
val=0;
tr=1;
folderPath = uigetdir('E:\mathlab\NUAA Dataset\Training\train_spoof', 'Select Folder Containing Images');
[allFeatures,label,lbpImage,feature]=processImageFolder1(folderPath,val,allFeatures,label,tr);
model=Training_img(allFeatures,label);
tr=0;
val=-1;
t=1;
b=1;
folderPath = 'E:\mathlab\NUAA Dataset\Testing\real_testing';
[allFeatures,label,lbpImage,feature]=processImageFolder1(folderPath,val,allFeatures,label,tr);
[predict_label,cout,k,cout1]=testing_img(model,feature,t,b,cout,cout1);
tr=0;
val=-1;
t=0;
b=2;
folderPath = 'E:\mathlab\NUAA Dataset\Testing\spoof_testing';
[allFeatures,label,lbpImage,feature]=processImageFolder1(folderPath,val,allFeatures,label,tr);
[predict_label,cout,k,cout1]=testing_img(model,feature,t,b,cout,cout1);
