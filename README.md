# DSPE
 Dual Self-Paced Ensemble for Imbalanced Data Classification
 
The utilization of synthetic minority oversampling technique (SMOTE)-based resampling
and resampling-based ensemble methods are prevalent when classifying tabulated
data with class imbalance. However, these approaches suffer from two major drawbacks:
inappropriate representation of sample density distributions and lack of consideration
for noise interference. To overcome these limitations, this study proposes
a dual self-paced ensemble (DSPE) framework, which combines self-paced learning
and ensemble learning. DSPE first computes the sample difficulty, which measures
the degree of difficulty to be correctly classified. We propose a hybrid sample difficulty
that considers both the sample distribution and the classifier’s prediction. Then
according to the probability density functions of the sample difficulty, DSPE performs
self-paced oversampling (SPO) and self-paced undersampling (SPU) for the minority
and majority classes, respectively, to obtain balanced subsets. SPO prioritizes difficult
minority class examples, while SPU prioritizes easy majority class examples. As
a result, safe majority class examples have a higher density than borderline majority
examples, while the minority class tends to have a higher density in borderline areas
than in safe areas. By improving the density distribution, the class boundaries become
more distinct. Finally, DSPE integrates base classifiers trained on balanced subsets using
majority voting. Extensive experiments demonstrate the superiority of DSPE over
nine SMOTE-based resampling and six resampling-based ensemble methods.
