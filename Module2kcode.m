
        
        function kmeans1 = gcodebook()
        srcFiles = dir('C:\Users\Dhana-PC\Documents\MATLAB\pics1\*.png');  % the folder in which ur images exists
imgFeatures = {};
for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\Dhana-PC\Documents\MATLAB\pics1\',srcFiles(i).name);
    I = imread(filename);
    %disp(filename)
%        figure, imshow(a);
      % pause
%I = imread('2164.png');
points = detectSURFFeatures(I);
[features, valid_points] = extractFeatures(I, points);
%CA = cat(1,features,features);
imgFeatures{i} = features;

%Combf = cat(1,imgFeatures{1,1},imgFeatures{1,2});
%figure; imshow(I); hold on;
%plot(valid_points.selectStrongest(10),'showOrientation',true);

end
for i = 2 : length(srcFiles)
    imgFeatures{1,1} = [imgFeatures{1,1}; imgFeatures{1,i}];
    imgfeaturesnew = {};
    imgfeaturesnew = [imgFeatures{1,1}];
end
        
              
            [idx, c] = kmeans(imgfeaturesnew,100)
            
                       
            %codebookDir = strcat(obj.RootPath,['/Database/Codebook/Kmean/',obj.ExtractorMethod,'/',obj.ImageDbName, '/']);

            save ('C:\Users\Dhana-PC\Documents\MATLAB\Codebook\codebook_1000_100_images.mat', 'c'); 
            
                       
            
        end
        