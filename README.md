# 2020-desimone-numerosity

Supporting information for:

>DeSimone, K., Kim, M., & Murray, R. F. (2020). Number adaptation can be dissociated from density adaptation. *Psychological Science, 31*(11), 1470-1474.

The directory 'data' contains trial-by-trial data from the number adaptation experiment. Each file contains data for a single subject in a single adaptation condition. The files are named num_A_B.txt, where A is the subject code (e.g., S1) and B is a flag (0 or 1) to indicate whether the condition included adaptation (1) or was a baseline condition with no adaptation (0).

The data file columns provide the following information.

refstim = reference stimulus number (1-3); these are the three numbered green points in Figures 1b and 1c \
nref = number of dots in reference stimulus \
ntest = number of dots in test stimulus \
rref = radius of reference stimulus (in pixels) \
rtest = radius of test stimulus (in pixels) \
response = observer's judgement of which stimulus had more dots reference stimulus, 2 = test stimulus \
rt = reaction time (in seconds) \

Stimulus sizes are given in pixels, so it is useful to know (as reported in the paper) that the pixel size was 0.250 mm and the viewing distance was 84 cm, so each pixel subtended 0.0171 degrees of visual angle.

The R script data/figure2.R uses the data files to recreate Figure 2 from the paper, which shows the effect of adaptation on the perceived number of dots. The code was written in R version 3.6.3 (2020-02-29).

Stimulus movies 1 and 2 demonstrate the number adaptation effect examined in the paper.
