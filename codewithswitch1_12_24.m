function [allFeatures,label,lbpImage,feature] =processImageFolder1(val,allFeatures,label,tr)
    % Select a folder with UI
    folderPath = uigetdir('', 'Select Folder Containing Images');
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
    % List to store the 59 LBP features of all images
    %allFeatures = [];
    %label=zeros(59,1);
    % Loop through each image in the folder
    for i = 1:numFiles
        % Read the image
        img = imread(fullfile(folderPath, imageFiles(i).name));
        %[row,col]=size(img);
        %r=row/4;
        %r1=fix(row/4);
        %c=col/4;
        %c1=fix(col/4);
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
        %disp(label(p))
        %disp(p)
    end
    % Optionally, save the results to a file (e.g., .mat file)
    %save('LBP_Features.mat', 'allFeatures');
    
    % Display a message that the processing is complete
    disp('Processing complete. LBP features extracted for all images.');
    %disp(allFeatures);
    % Plot the LBP histogram for this image
    %figure;
    %bar(lbpHist);
    %title(['Histogram of LBP Features for ', imageFiles(1).name]);
    %xlabel('LBP Pattern Index');
    %ylabel('Frequency');

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
choice=input('enter 1 to continue or  5 to stop\n');

allFeatures = [];
label=[];
cout=0;
cout1=0;
while choice ~= 5
    choice=input('enter your choice\n1-real\n2-Fake\n3-test real\n4-test fake\n5-exit\n');
    switch choice
        case 1
            disp('chose option 1 for Training real image ');
            val=1;
            tr=1;
            [allFeatures,label,lbpImage]=processImageFolder1(val,allFeatures,label,tr);
            model=Training_img(allFeatures,label);
        case 2
            disp('chose option 2 for Training Fake image ');
            val=0;
            tr=1;
            [allFeatures,label,lbpImage,feature]=processImageFolder1(val,allFeatures,label,tr);
            model=Training_img(allFeatures,label);
        case 3
            disp('chose option 3 for testing Real image');
            tr=0;
            val=-1;
            t=1;
            b=1;
            [allFeatures,label,lbpImage,feature]=processImageFolder1(val,allFeatures,label,tr);
            [predict_label,cout,k,cout1]=testing_img(model,feature,t,b,cout,cout1);
        case 4
            disp('chose option 4 for testing Fake image');
            tr=0;
            val=-1;
            t=0;
            b=2;
            [allFeatures,label,lbpImage,feature]=processImageFolder1(val,allFeatures,label,tr);
            [predict_label,cout,k,cout1]=testing_img(model,feature,t,b,cout,cout1);
        case 5
            disp('chose option 5 for exit');
        otherwise
            disp('invalid choice');
    end
end
