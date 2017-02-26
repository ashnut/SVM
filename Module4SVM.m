clear;

QueryDbName = 'RetiDB Test Set'; %Query Data that gonna be used (change if you want to use other database e.g "COREL_1000"). 
                         %Note: * Please Copy the training image into specified folder
                         %      * Currently this progam can only support jpg file format
                         %      * Use series of number as image name e.g 1,2,3, . . .,10
                         
CodebookDbName = 'RetiDb-Microaneurysm';
                         
ExtractorMethod= 'SURF'; %Feature Extraction method that gonna be used (change if you want to use other method e.g "SURF"). 
                         %Note: * Currently can only use SURF as feature extraction method
                         
                         
QuantizationMethod = 'Kmean';
                         
RootPath = 'C:/Users/Dhana-PC/Documents/MATLAB';

% 1. Preparing Result Data Structure

C_paramater = 1.0;
C = '1.0';
numOfWord = '100';
classification_result = [];

classification_result.training_image = 'DR1';
classification_result.query_image = 'RetiDb';
classification_result.quantization_method = 'Kmean';
classification_result.number_of_words = 100;
classification_result.classifier = 'SVM';
classification_result.classifier_parameter = C_paramater;
classification_result.TP = 0;
classification_result.FP = 0;
classification_result.TN = 0;
classification_result.FN = 0;

% 2. Preparing Query Data
% 2.1 Extracting Query Data's Feature

% disp('Generating Image Feature...');
% featureExtractor = FeatureExtractor(QueryDbName,ExtractorMethod,RootPath);

% 2.2 Generating Query Data's Histogram 

disp('Generating Histrogram...');
histogramConstructor = EcludianDistanceHistogram1(QueryDbName,ExtractorMethod,RootPath,QuantizationMethod,CodebookDbName,'Query');
query_histogram = getHist(histogramConstructor);

query_data = zeros(size(query_histogram,2),classification_result.number_of_words);
for i=1:size(query_histogram,2)
    temp = query_histogram{i};
    query_data(i,:) = temp;
end


%% RetiDB Test Set
query_label = ones(size(query_histogram,2),1);
query_label(5:8) = 0;
disp('Query Size');
disp(size(query_label));
classification_result.query_label = query_label';


% 3. Preparing Training Data
% 3.1 Loading Training Histogram

trainingFilename = 'C:/Users/Dhana-PC/Documents/MATLAB/Histogram/image_histogram.mat';
    
training_histogram = load(trainingFilename);
training_histogram = training_histogram.Histogram;

% 3.2 Arranging training histogram into format that accepted by SVM
% classifier

training_data = zeros(size(training_histogram,2),classification_result.number_of_words);
for i=1:size(training_histogram,2)
    temp = training_histogram{i};
    training_data(i,:) = temp;
end

disp(size(training_data));
% 3.3 labelling training data
% 1 = Positive , -1 = Normal
% Currently we need to do manually
% Preferebly reading label from     

% Note:
% *) DR1 Training Set -> 1:686 = Normal, 687:929 = Exudates
% Normal = 1, Not Normal = 0
n = size(training_histogram,2);

% % RetiDb-Microaneurysm
training_label = zeros(n,1);
training_label(1:50) = 1;
training_label(51:100) = 0;
disp('Training Size');
disp(size(training_label));

classification_result.training_label = training_label';

% 4. Training SVM
disp('CHECK')
disp(size(training_data))

disp(size(training_label))

svmStruct = svmtrain(training_data,training_label,'boxconstraint',C_paramater);

% 5. Classifying Query Image
total = 0;
classification_label = svmclassify(svmStruct,query_data);  
disp(classification_label);

classification_result.classification_label = classification_label';
classification_result.total_image = total;

plotconfusion(classification_result.query_label,classification_result.classification_label)

    
    histogramDir = strcat(RootPath,'/Database1/Result/SVM/');
    filename = strcat(['classification_result_',CodebookDbName,'-', QueryDbName ,'_K-', numOfWord,'_C-', C ],'.mat');
    save ([histogramDir,filename], 'classification_result');