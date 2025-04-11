# Mustelid_monitoring
Repository for data and code for the publication: Pieter J. Otte, Tim. R. Hofmeester, Jasja Dekker, Bob Jonge Poerink & Christian Smit. 2025. Optimizing Small Mustelid Monitoring: Enclosed Camera Traps Increase Detection of Smallest Carnivores.

<b>Abstract</b>
1.	 Land use change in Europe is causing declines in once-abundant species. As a result, small mustelids are indicated to be declining across their original range. Due to their small size and elusive ecology, small mustelids are challenging to monitor and remain understudied. In this study, we test the effectiveness of camera traps of varying degrees of enclosure to monitor common weasel Mustela nivalis, stoat Mustela erminea, and European polecat Mustela putorius. 
2.	 We deployed unenclosed, semi-, and fully enclosed camera traps in a clustered design containing all methods, in the fall of 2023, in two study areas in the Netherlands. Furthermore, we evaluated the effect of scent-based lures and placement near passages on the detection probability of the three species. We used multi-scale occupancy models to estimate the detection probability of each camera-trapping method and tested for the effect of scent-based lures and the placement of cameras near passages. 
3.	 We found that weasels had the highest detection probability in fully enclosed camera traps placed within clusters containing a scent-based lure. The detection probability of stoats was highest in fully enclosed camera traps, regardless of whether a lure was present or absent, and in unenclosed camera traps with no lure nearby. Polecats had the highest detection probability for unenclosed camera traps regardless of lure, and semi-enclosed camera traps without lure in proximity. Placing camera traps near passages increased the detection probability for all three species. 
4.	 <i>Synthesis and application</i>: Our findings demonstrate that monitoring small mustelids can be optimized by considering different types of enclosed camera traps. The differences in size and ecology among the three small mustelid species likely explain the variations in the effectiveness of the three camera-trapping methods. Thus, species-specific considerations regarding the camera-trapping method, scent-based lures, and placement near passages should be made when studying small mustelids. To efficiently assess the decline of small mustelids, researchers and wildlife managers should consider a combination of unenclosed and fully enclosed camera traps that will allow for effective monitoring of small mustelids and other carnivores.

<b>Data</b>

The MSocc- files provide the detection data of the three small mustelid species: common weasel, stoat, and European polecat. Detection histories are given in an array of three dimensions: 1) Clusters (i), 2) camera trapping methods within the clusters in the order Mostela, Tubecam, Regular camera trap (j) and 3) daily detection (k). See manuscript for more information.

The R-script contains the description of the models and code to run the models using the jagsUI package.

<b>Repository</b>

A secured version of the data and code as used in the published article can be found on Zenodo when the manuscript is accepted.
