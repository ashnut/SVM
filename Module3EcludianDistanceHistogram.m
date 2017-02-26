classdef EcludianDistanceHistogram < HistogramConstructor
    %ECLUDIANDISTANCEHISTOGRAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = EcludianDistanceHistogram(ImageDbName,ExtractorMethod,RootPath,QuantizationMethod,CodebookDbName,Mode)
            obj = obj@HistogramConstructor(ImageDbName,ExtractorMethod,RootPath,QuantizationMethod,CodebookDbName,Mode);
        end
        
        function obj = generateHist(obj,Mode)
            disp('Calling GenerateHist');
            numImage = size(obj.ImageFeature,1);
            numWords = size(obj.Codebook,1);
            Histogram = {};
            
            disp(numImage)
            disp(size(obj.ImageFeature))
                          
            for imageIndex = 1:numImage
                
                numFeature =  size(obj.ImageFeature{imageIndex},1);
                ImageFeature = obj.ImageFeature{imageIndex};
                D = zeros(numFeature,numWords);
                
                for wordsIndex=1:numWords
                    X1 = [obj.Codebook(wordsIndex,:);ImageFeature];
                    d1 = pdist(X1);
                    D(:,wordsIndex)=d1(1:numFeature);
                end
                
                [value hj]=min(D,[],2);
                
                x = 1:numWords;
                n = hist(hj,x);
                Histogram{imageIndex} = n;
            end
                
            obj.ImageHistogram = Histogram;
                
            
            if(strcmp(Mode,'Training'))
                histogramDir = 'C:\Users\Dhana-PC\Documents\MATLAB\Histogram\';

                save ([histogramDir,'image_histogram.mat'], 'Histogram'); 
            end
                            
        end
        
        function Histogram = getHist(obj)
            numImage = size(obj.ImageFeature,1);
            numWords = size(obj.Codebook,1);
            Histogram = {};
                          
            for imageIndex = 1:numImage
                
                numFeature =  size(obj.ImageFeature{imageIndex},1);
                ImageFeature = obj.ImageFeature{imageIndex};
                D = zeros(numFeature,numWords);
                
                for wordsIndex=1:numWords
                    X1 = [obj.Codebook(wordsIndex,:);ImageFeature];
                    d1 = pdist(X1);
                    D(:,wordsIndex)=d1(1:numFeature);
                end
                
                [value hj]=min(D,[],2);
                
                x = 1:numWords;
                n = hist(hj,x);
                Histogram{imageIndex} = n;
            end
                
            obj.ImageHistogram = Histogram;
                                            
        end
    end
    
end

