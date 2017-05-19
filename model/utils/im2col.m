function [ y ] = im2col( tensor3d )
    %IM2COL Rearrange 3*3 image patches into matrix columns 
    %   Args:
    %     tensor3d: [ (im_size+2) * (im_size+2) * deepth ], 
    %       tensor3d must be a padded images.
    %   Return:
    %     y: [ (kr_size^2 * deepth) * (im_size * im_size) ]
    %   Notes:
    %     In VGG16, we assert kernel size = 3, i.e. kr_size = 3
    %     Assert real image size = input_rows-2
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    kr_size = 3;
    im_size = size(tensor3d, 1) - 2;
    deepth = size(tensor3d, 3);
    
    index = repmat([0, 1, 2], [1, im_size]) + ...
            reshape(repmat(1:im_size, [kr_size, 1]), [1, kr_size*im_size]);
    
    A = permute(tensor3d, [2, 1, 3]);
    B = reshape(A(index, index, :), ...
                [kr_size*im_size, kr_size, im_size, deepth]);
    C = reshape(permute(B, [2, 1, 4, 3]), ...
                [kr_size*kr_size, im_size, deepth, im_size]);
    y = reshape(permute(C, [1, 3, 2, 4]), ...
                [kr_size*kr_size*deepth, im_size*im_size]);

end