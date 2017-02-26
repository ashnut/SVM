classdef HistogramConstructor
    %HISTOGRAMCONSTRUCTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        ImageDbName             %Image database name e.g "Corel_1000"
        ExtractorMethod         %Image feature extraction method name e.g "SURF"
        RootPath                %Root path of the program
        QuantizationMethod
        ImageFeature
        Codebook                %a 'k' set of visual word
        ImageHistogram
    end
    
    methods
        function obj = HistogramConstructor(ImageDbName,ExtractorMethod,RootPath,QuantizationMethod,CodebookDbName,Mode)
            %   Mode = Training or Query
            %           * Training      -> Load image feature of all training image
            %           * Query         -> Load image feature of one image
            %                              query
            %'C:\Users\Dhana-PC\Documents\MATLAB
            
            
            obj.ImageDbName = ImageDbName;
            obj.ExtractorMethod = ExtractorMethod;
            obj.RootPath = RootPath;
            obj.QuantizationMethod = QuantizationMethod;
            obj.ImageFeature = obj.loadImageFeature(Mode);
            obj.Codebook = obj.loadCodebook(CodebookDbName,Mode);
           
        end
        
        function obj = generateHist(obj)
            disp('HistogramConstructor');
            disp(obj.QuantizationMethod);
            disp(size(obj.Codebook));
%             disp(obj.ImageFeature{1});
        end
        
        function ImageDbName = get.ImageDbName(obj)
            ImageDbName = obj.ImageDbName;
        end
        
        function ExtractorMethod = get.ExtractorMethod(obj)
            ExtractorMethod = obj.ExtractorMethod;
        end
        
        function RootPath = get.RootPath(obj)
            RootPath = obj.RootPath;
        end
        
        function ImageFeature = get.ImageFeature(obj)
            ImageFeature = obj.ImageFeature;
        end
        
        function Codebook = get.Codebook(obj)
           Codebook = obj.Codebook; 
        end
        
        function ImageHistogram = get.ImageHistogram(obj)
            ImageHistogram = obj.ImageHistogram;
        end
        
        function obj = set.ImageHistogram(obj,ImageHistogram)
            obj.ImageHistogram = ImageHistogram;
        end
    end
    
    methods (Access = protected)
       function ImageFeature = loadImageFeature(obj,Mode)
           if(strcmp(Mode,'Training'))
                ImageFeature = {};
            
                fileName = 'C:\Users\Dhana-PC\Documents\MATLAB\Interestpoint\InterestPointsNew_500.mat';

                ImageFeature = load(fileName, 'imgfeaturesnew');

                ImageFeature = ImageFeature.imgfeaturesnew;
           else
                ImageFeature = {};
            
                fileName = 'C:\Users\Dhana-PC\Documents\MATLAB\Interestpoint\InterestPointsNew_500.mat';

                ImageFeature = load(fileName, 'imgfeaturesnew');

                ImageFeature = ImageFeature.imgfeaturesnew;
           end
       end
       
       function Codebook = loadCodebook(obj,CodebookDbName,Mode)
           if(strcmp(Mode,'Training'))
               fileName = 'C:\Users\Dhana-PC\Documents\MATLAB\Codebook\codebook_500_100_images.mat';
               Codebook = load(fileName,'c');
               Codebook = Codebook.c;
           else
               fileName = 'C:\Users\Dhana-PC\Documents\MATLAB\Codebook\codebook_500_100_images.mat';
               Codebook = load(fileName,'c');
               Codebook = Codebook.c;
           end
       end
    end
    
end

