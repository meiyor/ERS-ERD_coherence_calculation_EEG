# ERS-ERD_coherence_calculation_EEG
This repository includes the Matlab code for Calculating the Event-Related Spectral Perturbation (ERSP) trials and Cortico-Muscular-Coherence (CMC) trials from the data collected in Mater Misericordiae Hospital, Dublin, Ireland in 2020.

### Requirements
- Matlab > R2020a
- EEGlab > 14.1.1

To run the ERSP with the corresponding results execute the following command in the Matlab command prompt
  
```matlab 
   run_evals_OG() %%calculate the ERSP and CMC resulting images in a 100x100 size for Overground Gait trials
   run_evals_EKSO() %%calculate the ERSP and CMC resulting images in a 100x100 size for EKSO exoskeleton device trials
```

Please notice this process will take some time for completing the whole executing for the six subjects - three Healthy Controls (HC) and three Stroke patients (ST). After you complete the code execution you can evaluate the statistics using the sample codes included in the **eval_stats** folder. Refer to the comments on those particular .m files if statistical models will be changed or evaluated in the different way.

For replicating the ERSP and CMC with other data, please refer to the data directory and following the code refered in the function  
**addMaterEEGdataEEGlab_bouts** and **addMaterEEGdataEEGlab_bouts_OG** . You can call the individual ERSP and/or CMC trial calculation using the following command on the Matlab prompt.

```matlab 
   addMaterEEGdataEEGlab_bouts(SUJECT_ID,RUN_TRIAL_ID,[100,100],1); %%SUBJECT_ID and RUN_TRIAL_ID are strings with subjec and run identifiers in your custom dataset
```
For the dataset you want to process please separate the EEG files on subjects and runs index for make the execution easier and also easier for replication.
