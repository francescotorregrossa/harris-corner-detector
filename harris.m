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

result = uint8(img);
[kpts, ~] = size(keypoints);
for k = 1:kpts
    result = insertMarker(result, [keypoints(k, 2) keypoints(k, 1)], 'x', 'color', 'red');
end

end