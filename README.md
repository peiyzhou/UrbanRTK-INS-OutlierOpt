# Risk-Averse Optimization-based Outlier Accommodation for RTK INS Fusion 

UrbanRTK-INS-OutlierOpt is an open-source framework that integrates Real-Time Kinematic (RTK) 
Global Navigation Satellite Systems (GNSS) with Inertial Navigation Systems (INS), 
utilizing a diagonal-form of Risk-Averse Performance-Specified (RAPS) Optimization approach.
The diagonal-form RAPS is an efficient (solved in polynomial time complexity) and elegant method, well-suited for real-time navigation.
This repository is designed to provide robust outlier accommodation in urban environments,
where GNSS signals are often compromised due to obstacles like buildings and bridges.

# Paper
W. Hu, Y. Hu, M. Stas, and J. A. Farrell. "Optimization-Based Outlier Accommodation for Tightly Coupled RTK-Aided Inertial Navigation Systems in Urban Environments". Accepted by IEEE Intl. Conf. on Intelligent Transportation Systems, Edmonton, Canada, 2024.


# Tutorials in this repo
1. IMU nonlinear time propagation using Quaternion. see `imu/insTimePropagation.m`.
2. Parser to Observation and Ephemeris RINEX files, see `parser/parserGnssObs.m` and `parser/parserGnssEph.m`. For more information refer to [RINEX 3.03](https://files.igs.org/pub/data/format/rinex303.pdf)
3. Implementation of Precise Point Positioning (PPP) corrections, such as the IGGtrop model (`corr/IGGtropSH_bl.m`, provided by IGGtrop paper author Dr. Wei Li, liwei@whigg.ac.cn) and SSR VTEC model (`corr/ssrVtecComputation.m`)

# Requirements
MATLAB (tested in version R2023a, certain toolboxes, such as [Optimization Toolbox](https://www.mathworks.com/help/optim/index.html?s_tid=CRUX_topnav), may be required.)

Python (tested in Python 3.9. For generating KML file using `results/createTrajKml.py`)

# Running Setup
Uncompress `data\univOfTexas\univOfTexas.7z`.

The main file to run is titled `multiGnssMain.m`.

The default setting is to perform GNSS-RTK-Aided INS using RAPS for outlier recommendation.

To switch between RTK and DGNSS (code measurement-based): `p.post_mode  = p.mode_rtkfloat;` for RTK float; `p.post_mode  = p.mode_dgnss;` for DGNSS.

To change estimation mode: `p.est_mode = p.raps_ned_est;` for RAPS; `p.est_mode = p.map_est;` for Extended Kalman Filter (EKF);  `p.est_mode = p.td_est;` for Threshold Decision (TD).

The results for EKF-INS-RTK, TD-INS-RTK, and RAPS-INS-RTK were previously computed and saved in `results/`. To see the analysis of the results, run `results/figure_plot_dgnss.m`.

Google Earth 3D View uses a KML file generated by `results/createTrajKml.py` where it reads the experimental results from MATLAB `.mat` data file.

# RAPS-RTK-INS Framework
[Detailed Solution to RAPS Optimization](https://escholarship.org/uc/item/38m9w3gj) (Sec. 6 Solutions to DiagRAPS)

<p align="center">
  <img src="https://github.com/Azurehappen/UrbanRTK-INS-OutlierOpt/assets/45580484/3fbf5612-53aa-4845-ba98-f3f8237f764f" alt="BlockDiagram_Updated" width="600"/>
</p>

# Experimental Results
The open-source [TEX-CUP](https://radionavlab.ae.utexas.edu/texcup-desc/) dataset (2019May09) is used.  The experimental route traversing areas within the west campus of The University of Texas at Austin and downtown Austin, contains viaducts, high-rise buildings, and dense foliage. Results are estimated through forward (real-time) processing.

The RTK-GNSS/INS integration utilizes single-frequency measurements from a Septentrio receiver GPS L1, GLONASS L1, GALILEO E1, and Beidou B1.  The inertial measurements are provided by the smartphone-grade Bosch BMX055 IMU with a sampling rate of 150 Hz.

## Statistic Comparison
The figure below shows positioning errors versus STDs. The left (right) plot shows the actual horizontal (vertical) positioning error versus the posterior error standard deviation predicted by the estimator. The black line in each plot represents the line of consistency along which the actual position-ing performance equals the predicted estimation accuracy. Consequently, the plots are divided into distinct regions:

1. Over-confident region: The region above the line of consistency represents a risky and unsafe estimation scenario.  In this region, the estimator is overconfident because its actual estimation error is greater than the estimator's theoretical characterization of its estimation error.

2. Conservative region: The region above the line of consistency represents a conservative estimation scenario.  In this region, the estimator achieves an actual accuracy that is better than it predicts.

<p align="center">
  <img src="https://github.com/user-attachments/assets/5e8ae50d-9952-49c2-b262-7f29c9b1781b" alt="err_std" width="600"/>
</p>
Horizontal:  EKF Conservative Rate: 68.47%; TD Conservative Rate: 68.88%; RAPS Conservative Rate: 83.34%

Vertical: EKF Conservative Rate: 67.11%; TD Conservative Rate: 68.11%; RAPS Conservative Rate: 82.69%

## Positioning Accuracy Comparison

Left panels: near the Dell Medical School buildings.

Right panels: near Sailboat Building (multiple skyscrapers surround the site)

### Results from the traditional Threshold Decision (TD) method (TD-RTK-INS)
Some results (red points) present positioning errors over 100 meters.
<p align="center">
  <img width="600" alt="td_area" src="https://github.com/user-attachments/assets/66dca034-ae4b-4c5e-b1b9-eeebe1fb1152">
</p>

### Results from RAPS-RTK-INS
<p align="center">
  <img width="600" alt="raps_area" src="https://github.com/user-attachments/assets/f848daf4-f8b7-4e28-90f9-0f9237a43d9c">
</p>

3D View from Google Earth (For the right panel above)
<p align="center">
  <img width="700" alt="view_3d" src="https://github.com/Azurehappen/UrbanRTK-INS-OutlierOpt/assets/45580484/93ab9fb7-72e1-4bff-a289-9abfa87d3f29">
</p>

## Full trajectory from RTK-INS-RAPS
<p align="center">
  <img width="600" alt="full_traj" src="https://github.com/user-attachments/assets/89c270fb-4acd-490e-b66e-1a126b4f1980">
</p>
