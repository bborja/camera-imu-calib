function demo_calibration(dataset_path, sequence_id)
    warning('off', 'all');
    add_all_paths;
    
    % Get sequence name, start-end frames and corresponding calibration
    % sequence
    [vid_seq_name, calib_seq_name, start_frame, end_frame, precalib_offset_one, precalib_offset_two] = get_seq_details(sequence_id);
    
    % Load camera calibration file
    fs = cv.FileStorage(fullfile(dataset_path, 'video_data', vid_seq_name, 'calibration.yaml'));

    % Get image size
    imsize = [ fs.imageSize{1}, fs.imageSize{2} ];
    
    % Load imu calibration
    if(sequence_id < 15)
        [B, ~, imu_initial_pitch, imu_initial_roll] = getGroundPlane( fullfile(dataset_path, 'video_data', calib_seq_name), 100);
    else
        [B, ~, imu_initial_roll, imu_initial_pitch] = getGroundPlane( fullfile(dataset_path, 'video_data', calib_seq_name), 100);
    end
    
    for fr = start_frame + 1 : end_frame
        im_l = imread( fullfile( dataset_path, 'video_data', vid_seq_name, 'frames', sprintf( '%08dL.jpg', fr ) ) );
        
        % Get horizon parameters...
        [hor_line_param, ~, points_2d_l, ~] = getVanishingPoints(B, imu_initial_pitch, imu_initial_roll, fr - 1, fullfile(dataset_path, 'video_data', vid_seq_name), fs, sequence_id, precalib_offset_one, precalib_offset_two);

        points_2d_l(:,1) = min(points_2d_l(:,1), imsize(1));
        points_2d_l(:,1) = max(points_2d_l(:,1), 1);
        
        %debuging - horizon line
        figure(1); clf;
        imshow(im_l); axis equal; axis tight; hold on;
        scatter(points_2d_l(:,1), points_2d_l(:,2)); hold on;
        plot([0, imsize(1)], hor_line_param(1) * [0, imsize(1)] + hor_line_param(2), 'c', 'linewidth', 3); hold on;
        plot([0, imsize(1)], hor_line_param(1) * [0, imsize(1)] + hor_line_param(2), 'y', 'linewidth', 1);
        drawnow;
        
    end
end
