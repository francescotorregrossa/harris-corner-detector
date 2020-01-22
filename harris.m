function [H, keypoints, result] = harris(img, n, t)

k = 0.04;
[h, w, ~] = size(img);
H = zeros([h, w], 'single');
[~, ~, dy, dx] = edge(img);

A = dx .^ 2;
B = dy .^ 2;
C = dx .* dy;

for i = 1+n:h-n
    for j = 1+n:w-n
        
        sumA = 0.0;
        sumB = 0.0;
        sumC = 0.0;
        for x = -n:n
            for y = -n:n
                sumA = sumA + A(i+x, j+y);
                sumB = sumB + B(i+x, j+y);
                sumC = sumC + C(i+x, j+y);
            end
        end
        
        det = sumA * sumB - sumC ^ 2;
        tr = (sumA + sumB) ^ 2;
        H(i, j) = det - k * tr;
        
    end
end

keypoints = [];
for i = 1+n:h-n
    for j = 1+n:w-n
        
        current = H(i, j);
        
        if current < t
            continue;
        end
        
        isMax = 1;
        for x = -n:n
            for y = -n:n
                temp = H(i+x, j+y);
                if temp > current
                    isMax = 0;
                    break;
                end     
            end
        end
        
        if isMax
            keypoints(end + 1, :) = [i, j];
        end
        
    end
end

red = img;
green = red;
blue = red;
kp = keypoints(:, 1) + (keypoints(:, 2) - 1) * h;
red(kp) = 255;
result = zeros([h, w, 3]);
result(:, :, 1) = red;
result(:, :, 2) = green;
result(:, :, 3) = blue;
result = uint8(result);

end