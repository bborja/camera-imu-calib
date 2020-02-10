function [maskSeaL, maskSeaR, maskSkyL, maskSkyR] = imuMask(hParam, sims, sim, masks_to_generate)
    sigma_value = [1, 1]; %sigma_x = 4, sigma_y = 1
    maskSeaL = zeros(sims(1), sims(2));
    maskSeaR = zeros(sims(1), sims(2));
    maskSkyL = zeros(sims(1), sims(2));
    maskSkyR = zeros(sims(1), sims(2));
	
	factor_height = sims(1) / sim(1);
    
    x = [0, 0, sims(2), sims(2)];
    
    y1_Sea = [sims(1), hParam(2) * factor_height, (hParam(1) * sim(2) + hParam(2)) * factor_height, sims(1)];
    y1_Sky = [0, hParam(2) * factor_height, (hParam(1) * sim(2) + hParam(2)) * factor_height, 0];
    y2_Sea = [sims(1), hParam(4) * factor_height, (hParam(3) * sim(2) + hParam(4)) * factor_height, sims(1)];
    y2_Sky = [0, hParam(4) * factor_height, (hParam(3) * sim(2) + hParam(4)) * factor_height, 0];
    
    %tic %debug time measure of mask generating
    %build masks and smoothen them with gaussian filter
    if(masks_to_generate == 1 || masks_to_generate == 3)
        maskSeaL = (double(poly2mask(x, y1_Sea, sims(1), sims(2))));
        maskSeaR = (double(poly2mask(x, y2_Sea, sims(1), sims(2))));
        mask_tmp_l = imgaussfilt(maskSeaL, sigma_value);
        mask_tmp_r = imgaussfilt(maskSeaR, sigma_value);
        
        maskSeaL = maskSeaL .* mask_tmp_l;
        maskSeaR = maskSeaR .* mask_tmp_r;
        %test convex region
        %maskSeaL = addHullMask(maskSeaL);
        
        %maskSeaL = imgaussfilt(maskSeaL, sigma_value);
        %maskSeaR = imgaussfilt(double(poly2mask(x, y2_Sea, sims(1), sims(2))), sigma_value);
    end
    if(masks_to_generate == 2 || masks_to_generate == 3)
        maskSkyL = double(poly2mask(x, y1_Sky, sims(1), sims(2)));
        maskSkyR = double(poly2mask(x, y2_Sky, sims(1), sims(2)));
        mask_tmp_l = imgaussfilt(maskSkyL, sigma_value);
        mask_tmp_r = imgaussfilt(maskSkyR, sigma_value);
        
        maskSkyL = maskSkyL .* mask_tmp_l;
        maskSkyR = maskSkyR .* mask_tmp_r;
    end
    %test_time = toc
    
   
    
    
    %debug masks draw
    %figure(77); clf; subplot(2,2,1); imagesc(maskSeaL); subplot(2,2,2); imagesc(maskSeaR);
    %subplot(2,2,3); imagesc(maskSkyL); subplot(2,2,4); imagesc(maskSkyR);
    %colormap gray;
end

function M = addHullMask(mask)
    M = mask;
    [~, eL] = get_edge_list(mask);
    eL = [eL, [0, 50; 50, 50]];
    edg_hull_ind = convhull(eL(1,:), eL(2,:));
    conv_water = eL(:,edg_hull_ind);
    ind_min = 1;
    ind_max = 2;
    for i = 1 : 50
        if(conv_water(1,ind_min) < i && conv_water(1, ind_max) > i)
            temp_k = (conv_water(2,ind_max) - conv_water(2,ind_min)) / (conv_water(1,ind_max) - conv_water(1,ind_min));
            temp_n = conv_water(2,ind_min) - temp_k * conv_water(1,ind_min);
            j = round(temp_k * i + temp_n);
            M(j,i) = 1;
        elseif(conv_water(1,ind_max) == i)
            M(conv_water(2,ind_max),i) = 1;
            ind_min = ind_min + 1;
            ind_max = ind_max + 1;
        elseif(conv_water(1,ind_min) == i)
            M(conv_water(2,ind_min,i)) = 1;
        end             
    end
end

function [E_out, edgelist] = get_edge_list(M)
    E = edge( double(M)*255, 'sobel' )  ;
    [L, num] = bwlabel(E, 8) ; 
    [nums,~]=hist(L(:),[0:num]) ;
    nums = nums(2:end) ; 
    [~, cls_id] = max(nums) ;
    E_out = zeros(size(E)) ; 
    E_out(L==cls_id) = 1 ;
    edgelist = regionprops(E_out, 'PixelList') ;
    edgelist = edgelist.PixelList' ;
end