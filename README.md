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

Please notice this process will take some time for completing the whole executing for the six subjects - three Healthy Controls (HC) and three Stroke patients (ST). After you complete the code execution you can evaluate the statistics using the sample codes included in the # eval_stats # folder. Refer to the comments on those particular .m files if statistical models will be changed or evaluated in the different way.
