function [vidSeq, calibSeq, start_frame, end_frame, offset_one, offset_two] = get_seq_details(vid_num)
    offset_one = 0;
    offset_two = 0;
    switch vid_num
        case 1
            vidSeq = 'kope67-00-00004500-00005050';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 2
            vidSeq = 'kope67-00-00025200-00025670';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 3
            vidSeq = 'kope67-00-00027400-00027650';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 4
            vidSeq = 'kope67-00-00040950-00041190';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 5
            vidSeq = 'kope67-00-00060561-00061461';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 6
            vidSeq = 'kope67-00-00061851-00062671';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 7
            vidSeq = 'kope67-00-00062671-00063461';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 8
            vidSeq = 'kope67-00-00067272-00067942';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 9
            vidSeq = 'kope67-00-00074432-00074612';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_two = -0.020;
        case 10
            vidSeq = 'kope71-01-00011210-00011320';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
            offset_two = 0.020;
        case 11
            vidSeq = 'kope71-01-00011520-00011800';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
            offset_two = 0.020;
        case 12
            vidSeq = 'kope71-01-00011800-00012000';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
            offset_two = 0.020;
        case 13
            vidSeq = 'kope71-01-00014337-00014547';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
            offset_two = 0.020;
        case 14
            vidSeq = 'kope71-01-00017650-00017825';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
            offset_two = 0.020;
        case 15
            vidSeq = 'kope75-00-00013780-00014195';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = -0.02;
        case 16
            vidSeq = 'kope75-00-00021500-00022160';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = -0.02;
        case 17
            vidSeq = 'kope75-00-00037550-00037860';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = -0.02;
        case 18
            vidSeq = 'kope75-00-00062200-00062500';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = -0.02;

        case 19
            vidSeq = 'kope81-00-00000560-00001080';
            calibSeq = 'scal1-00-00000050-00000100';

        case 20
            vidSeq = 'kope81-00-00004330-00004850';
            calibSeq = 'scal1-00-00000050-00000100';

        case 21
            vidSeq = 'kope81-00-00006800-00007095';
            calibSeq = 'scal1-00-00000050-00000100';

        case 22
            vidSeq = 'kope81-00-00010940-00011100';
            calibSeq = 'scal1-00-00000050-00000100';

        case 23
            vidSeq = 'kope81-00-00015980-00016270';
            calibSeq = 'scal1-00-00000050-00000100';

        case 24
            vidSeq = 'kope81-00-00019370-00019710';
            calibSeq = 'scal1-00-00000050-00000100';

        case 25
            vidSeq = 'kope81-00-00021520-00022080';
            calibSeq = 'scal1-00-00000050-00000100';

        case 26
            vidSeq = 'kope81-00-00022350-00022520';
            calibSeq = 'scal1-00-00000050-00000100';

        case 27
            vidSeq = 'kope82-00-00011177-00011797';
            calibSeq = 'scal1-00-00000050-00000100';
        case 28
            vidSeq = 'kope82-00-00012030-00012700';
            calibSeq = 'scal1-00-00000050-00000100';
    end
    
    tmp_split = strsplit(vidSeq, '-');
    start_frame = str2double(tmp_split(3));
    end_frame = str2double(tmp_split(4));
end

function [vidSeq, calibSeq, start_frame, end_frame, offset_one, offset_two, alpha_one] = getVideoSequence(vid_num)
    offset_one = 0;
    offset_two = 0;
    alpha_one = 1;
    
    framesOffsetStart = 0;
    framesOffsetEnd = 0;
    
    
    switch vid_num
        case 1
            vidSeq = 'kope67-00-00004500-00005050';
            calibSeq = 'scal1-00-00000050-00000100';
        case 2
            vidSeq = 'kope67-00-00025200-00025670';
            calibSeq = 'scal1-00-00000050-00000100';
        case 3
            vidSeq = 'kope67-00-00027400-00027650';
            calibSeq = 'scal1-00-00000050-00000100';
        case 4
            vidSeq = 'kope67-00-00040950-00041190';
            calibSeq = 'scal1-00-00000050-00000100';
        case 5
            vidSeq = 'kope67-00-00060561-00061851';
            calibSeq = 'scal1-00-00000050-00000100';
            framesOffsetEnd = 61461;
        case 6
            vidSeq = 'kope67-00-00061851-00062671';
            calibSeq = 'scal1-00-00000050-00000100';
        case 7
            vidSeq = 'kope67-00-00062671-00063461';
            calibSeq = 'scal1-00-00000050-00000100';
        case 8
            vidSeq = 'kope67-00-00067272-00067942';
            calibSeq = 'scal1-00-00000050-00000100';
        case 9
            vidSeq = 'kope67-00-00074432-00074612';
            calibSeq = 'scal1-00-00000050-00000100';
        case 10
            vidSeq = 'kope71-01-00011210-00011320';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
        case 11
            vidSeq = 'kope71-01-00011520-00011800';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
        case 12
            vidSeq = 'kope71-01-00011800-00012000';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
        case 13
            vidSeq = 'kope71-01-00014337-00014547';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
        case 14
            vidSeq = 'kope71-01-00017650-00017825';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.075;
        case 15
            vidSeq = 'kope75-00-00013780-00014195';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.12;
            offset_two = -0.18;
            %alpha_one = 0.95;
        case 16
            vidSeq = 'kope75-00-00021500-00022160';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.12;
            offset_two = -0.18;
            %alpha_one = 0.95;
        case 17
            vidSeq = 'kope75-00-00037550-00037860';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.12;
            offset_two = -0.18;
            %alpha_one = 0.95;
        case 18
            vidSeq = 'kope75-00-00062200-00062500';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.12;
            offset_two = -0.18;
            %alpha_one = 0.95;
        case 19
            vidSeq = 'kope81-00-00000560-00001080';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
        case 20
            vidSeq = 'kope81-00-00002230-00003200';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
        case 21
            vidSeq = 'kope81-00-00004330-00004850';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
        case 22
            vidSeq = 'kope81-00-00006800-00007180';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
            framesOffsetEnd = 7095;
        case 23
            vidSeq = 'kope81-00-00010940-00011500';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
            framesOffsetEnd = 11100;
        case 24
            vidSeq = 'kope81-00-00015980-00016270';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
        case 25
            vidSeq = 'kope81-00-00019370-00019710';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
        case 26
            vidSeq = 'kope81-00-00021520-00022520';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
            framesOffsetEnd = 22080;
        case 31
            vidSeq = 'kope81-00-00021520-00022520';
            calibSeq = 'scal1-00-00000050-00000100';
            offset_one = 0.2;
            offset_two = -0.18;
            alpha_one = 1;
            framesOffsetStart = 22350;
        case 27
            vidSeq = 'kope82-00-00011177-00011797';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.2;
            offset_two = -0.1;

        case 28
            vidSeq = 'kope82-00-00012030-00012700';
            calibSeq = 'scal0-00-00000100-00000200';
            offset_one = 0.2;
            offset_two = -0.1;
    end
    
    temp = strsplit(vidSeq, '-');

    if(framesOffsetStart == 0)
        start_frame = str2double(temp(3));
    else
        start_frame = framesOffsetStart;
    end
    
    if(framesOffsetEnd == 0)
        end_frame = str2double(temp(4));
    else
        end_frame = framesOffsetEnd;
    end

end