% Return ground plane equation B and initial IMU measurements from
% calibration sequence
function [B, R_camusv, imu_pitch, imu_roll] = getGroundPlane(path, fr_num)
    %% PATHS
    path_PCD = fullfile(path, 'pcl-pointcloud');
    path_IMU = fullfile(path, 'imu');
    
    %% Load IMU measurements offset from calibration sequence
    imu = load(fullfile(path_IMU, sprintf('%08d.txt', fr_num)));
    imu_pitch = imu(1); % Initial offset of pitch parameter
    imu_roll = imu(2); % Initial offset of roll parameter

    %% Load PCD
    pcd_data = loadpcd(fullfile(path_PCD, sprintf('%08d.pcd', fr_num)));
    % Remove information about RGB value
    all_points = double(pcd_data(1:3, :)');    
    
    %% Additional limitations (distance from camera)
    % (The points' coordinates are written in mm)
    % (Choose only points that are closer than 10m from the camera system)
    close_points = all_points(all_points(:, 3) < 10000, :);
    
    %% Sample points for faster plane fitting
    % If there are many points, then sample only 10000 points. This should
    % be enough for the good approximation of the ground plane
    if(length(close_points) > 10000)
        close_points = sampleT(close_points, 10000);
    else
        close_points = close_points;
    end
        
    %% Fit plane on sampled points using RANSAC
    % When fitting the plane allow up to 100mm of an error
    [B, ~, ~] = ransacfitplane(close_points', 100);
    
    %% Find plane angles
    % Angles at which the plane is rotated in space
    xtest = [-6000, 8000, 8000];
    ztest = [0, 0, 10000];
    ytest = (-B(1)*xtest - B(3)*ztest - B(4)) / B(2);
    rot_x = atand( (ytest(3) - ytest(2)) / (ztest(3) - ztest(2)) );
    rot_z = atand( (ytest(2) - ytest(1)) / (xtest(2) - xtest(1)) );
    
    % Rotation matrix from camera system to the world system
    % (Euler angles to rotation matrix ZYX order)
    R_camusv = inv(rotz(rot_z)) * roty(0) * rotx(rot_x);
    
    % Rotate all points and position them in horizontal position
    close_points = R_camusv * close_points';
    
    % Get new plane equation
    [B, ~, ~] = ransacfitplane(close_points, 100);        
end