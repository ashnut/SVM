function imgfeaturesnew = forsurf()
srcFiles = dir('C:\Users\Dhana-PC\Documents\MATLAB\pics2\*.png');  % the folder in which ur images exists
%imgFeatures = {};
imgfeaturesnew = {};
for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\Dhana-PC\Documents\MATLAB\pics2\',srcFiles(i).name);
    I = imread(filename);
   % disp(filename);
%        figure, imshow(a);
      % pause
%I = imread('2164.png');
points = detectSURFFeatures(I);
[features, valid_points] = extractFeatures(I, points);
%disp(i)
%disp(size(features));
%CA = cat(1,features,features);
%imgFeatures{i} = features;


%Combf = cat(1,imgFeatures{1,1},imgFeatures{1,2});
figure; imshow(I); hold on;
plot(valid_points.selectStrongest(100),'showOrientation',true);

%end
%for i = 1 : length(srcFiles)
 %  imgFeatures{1,1} = [imgFeatures{1,1}; imgFeatures{1,i}];
   
    imgfeaturesnew{i,1} = features;
    
    %disp(fer1);
end

save ('C:\Users\Dhana-PC\Documents\MATLAB\Interestpoint\InterestPointsNew_1000_images.mat','imgfeaturesnew');
end

