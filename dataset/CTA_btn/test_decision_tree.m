% TrainingSet=[ 1 10;2 20;3 30;4 40;5 50;6 66;3 30;4.1 42]; 
TrainingSet=[ 1 0;2 20;3 30;4 40;5 50;6 66;3 30;4.1 42]; 
TestSet=[3 34; 1 14; 2.2 25; 6.2 63]; 
GroupTrain=[1;1;2;2;3;3;2;2]; 
results = multisvm(TrainingSet, GroupTrain, TestSet); 
disp('multi class problem'); 
disp(results);