# ERS-ERD_coherence_calculation_EEG
This repository includes the Matlab code for Calculating the Event-Related Spectral Perturbation (ERSP) trials and Cortico-Muscular-Coherence (CMC) trials.

### Requirements
- Matlab > R2020b
- EEGlab > 14.1.1

For the python code we provide:

__1.__ A baseline code to evaluate a Leave-One-Trial-Out cross-validation from two csv files. One including all the trials for train with their corresponding labels and other with the test features of the single trial you want to evaluate. The test and train datafile should have an identifier to be paired by the for loop used for the cross validation. The code to run the baseline classifiier is located on the folder **classifier_EEG_call**.

![Pipeline for EEG Emotion Decoding](https://github.com/meiyor/Deep-Learning-Emotion-Decoding-using-EEG-data-from-Autism-individuals/blob/master/pipeline_2_using_latex.jpeg)

  To run the classifier pipeline simply download the .py files on the folder **classifier_EEG_call** and execute the following command on your bash prompt:
  
```python 
   python LOTO_lauch_emotions_test.py "data_path_file_including_train_test_files"
```
