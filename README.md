# Quick Camera-IMU Calibration
A Quick and Effective Camera-IMU Calibration for MODD2 dataset, written in Matlab.
https://doi.org/10.1016/j.robot.2018.02.017

Requirements: Matlab2016+ with OpenCV3.0+ library

There are two main functions: <i>getGroundPlane</i> and <i>getVanishingPoints</i>

### getGroundPlane:
This function fits a plane on the ground points located in-front-of the USV and reads the initial rotations provided by the on-board IMU. From this we can obtain two rotation matrices (1) R_{CAM}^{W} (rotation from the camera coordinate system to the world coordinate system)  and R_{IMU}^{W} (rotation from the IMU coordinate system to the world coordinate system).

### getVanishingPoints:
This function reads current measurements of the IMU. Based on this measurements it rotates the points in infinity accordingly. By projecting the colinear points from the infinity to the camera plane we are able to obtain the location of the horizon line.

### Running the demo
To run the example calibration simply call the demo_calibration.m script. The script expects two input parameters: (1) path to the root directory of the MODD2 dataset and (2) sequence ID (a number from interval [1,..,28]). Example function call:
```
demo_calibration('../MarineDatasets/MODD2', 14)
```

### Results
TODO yt video


### Cite
If you use the provided code, please cite our paper:
```
@article{bovcon2018stereo,
  title={Stereo obstacle detection for unmanned surface vehicles by IMU-assisted semantic segmentation},
  author={Bovcon, Borja and Per{\v{s}}, Janez and Kristan, Matej and others},
  journal={Robotics and Autonomous Systems},
  volume={104},
  pages={1--13},
  year={2018},
  publisher={Elsevier}
}
```
