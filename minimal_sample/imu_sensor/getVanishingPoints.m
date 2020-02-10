function [horizon_params, R, points_2d_l, points_2d_r] = getVanishingPoints(B, imu_pitch_initial, imu_roll_initial, fr_num, path, fs, seq_id, varargin)
    %% PATHS
    path_IMU = fullfile(path, 'imu');
    % Get initial pitch and roll angles form the IMU
    imu_pitch_initial = imu_pitch_initial + varargin{1};
    imu_roll_initial = imu_roll_initial + varargin{2};
    
    %% Load IMU measurements offset from calibration sequence
    imu_current = load(fullfile(path_IMU, sprintf('%08d.txt', fr_num)));
    if(seq_id < 15)
        imu_pitch = rad2deg(imu_current(1) - imu_pitch_initial  + 0.128);
        imu_roll = rad2deg(imu_current(2) - imu_roll_initial);
    else
        imu_pitch = rad2deg(imu_current(2) - imu_pitch_initial + 0.128);
        imu_roll = rad2deg(imu_current(1) - imu_roll_initial);
    end

    
    %% Findinding vanishing points
    % Select 2x 2 pair of lines from plane B, that are paralel in their z
    % direction. Based on this lines we can compute 2 vanishing points
    
    % Build rotation matrix from imu measurements
    R = inv(rotz(imu_roll)) * roty(0) * rotx(imu_pitch);
    % Rotate selected points by imu measurements
    
        
    %% Numericaly stable method for finding the horizon
    point_distance = 50000000; %distance in mm (= 50km)
    point_angle = 40; %in degrees
    
    points = zeros(3,3);
    % X coordinates of points
    points(1,1) = tand(point_angle) * point_distance;
    points(2,1) = tand(-point_angle) * point_distance;
    points(3,1) = 0;
    % Z coordinates of points
    points(:,3) = [point_distance; point_distance; point_distance];
    % Y coordinates of points (on the offsetted plane)
    points(1,2) = ((-B(1) * points(1,1) - B(3) * points(1,3) - B(4)) / B(2));
    points(2,2) = ((-B(1) * points(2,1) - B(3) * points(2,3) - B(4)) / B(2));
    points(3,2) = ((-B(1) * points(3,1) - B(3) * points(3,3) - B(4)) / B(2));
    
    points = (R * points')'; % Rotate the points according to the IMU
    
    % Project points in the infinity (on the horizon) to the camera plane
    points_2d_l = cv.projectPoints(points, eye(3), [0,0,0], fs.M1, 'DistCoeffs', fs.D1);
    points_2d_r = cv.projectPoints(points, eye(3), [0,0,0], fs.M2, 'DistCoeffs', fs.D2);
    
    %undistort points because we are working with rectified images
    %undist_points_l = cv.undistortPoints( points_2d_l, fs.M1, fs.D1, 'R', S.R1, 'P', S.P1);
    %undist_points_r = cv.undistortPoints( points_2d_r, fs.M2, fs.D2, 'R', S.R2, 'P', S.P2);
    
    
    hor_param_l = getHorizonFromPoints(points_2d_l);
    hor_param_r = getHorizonFromPoints(points_2d_r);
    horizon_params = [hor_param_l, hor_param_r];
    
end

% Get line connecting the vanishing points
function horizon_params = getHorizonFromPoints(v_points)
    tmp_k = (v_points(1,2) - v_points(2,2)) / (v_points(1,1) - v_points(2,1));
    tmp_n = v_points(1,2) - tmp_k * v_points(1,1);
    horizon_params = [tmp_k, tmp_n];
end