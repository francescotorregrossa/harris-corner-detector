## Harris corner detector

Given an image ![](https://render.githubusercontent.com/render/math?math=I(p)) where ![](https://render.githubusercontent.com/render/math?math=p) represents the coordinates of a pixel, it's possible to detect if the local neighbourhood of ![](https://render.githubusercontent.com/render/math?math=p) contains a corner by using the [Harris corner detector](https://en.wikipedia.org/wiki/Harris_Corner_Detector).

The standard implementation works by using the autocorrelation matrix

<p align="center">
<img src="https://render.githubusercontent.com/render/math?math=%5Cmu(p)%20%3D%20%5Cbegin%7Bbmatrix%7D%5Csum_%7Bq%20%5Cin%20N%7D%20I_x%5E2(q)%20%26%20%5Csum_%7Bq%20%5Cin%20N%7D%20I_x(q)I_y(q)%20%5C%5C%5Csum_%7Bq%20%5Cin%20N%7D%20I_x(q)I_y(q)%20%26%20%5Csum_%7Bq%20%5Cin%20N%7D%20I_y%5E2(q)%20%5C%5C%5Cend%7Bbmatrix%7D" />
</p>

where ![](https://render.githubusercontent.com/render/math?math=I_x) and ![](https://render.githubusercontent.com/render/math?math=I_y) are the partial derivatives of ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;I). The determinant and the trace of this matrix are high respectively when there is a corner and when there is an edge or corner. Thus, we can define the matrix ![](https://render.githubusercontent.com/render/math?math=H(p)) such that ![](https://render.githubusercontent.com/render/math?math=H(p)%20%5Cgg%200) when there is a corner and ![](https://render.githubusercontent.com/render/math?math=H(p)%20%5Cll%200) when there is an edge as
<p align="center">
<img src="https://render.githubusercontent.com/render/math?math=H(p)%20%3D%20%5Cdet(%5Cmu(p))%20-%20k%20%5Cmathrm%7Btr%7D%5E2(%5Cmu(p))" />
</p>

with a normalisation factor ![](https://render.githubusercontent.com/render/math?math=k). We can then define a corner as a point ![](https://render.githubusercontent.com/render/math?math=p) in ![](https://render.githubusercontent.com/render/math?math=H(p)) such that ![](https://render.githubusercontent.com/render/math?math=p) is a local maximum and that ![](https://render.githubusercontent.com/render/math?math=H(p)%20%5Cgt%20t%20%5Cgt%200).



### Implementation and usage

This implementation is only meant to be used to study the topic. It has a fixed value for `k = 0.04` and takes `t` and `n` as parameters, where `n` represents the size of the window in which to perform the operations (e.g. if `p` is the center of the window and `n = 2`, then the window will go from `p-2` to `p+2` in both directions, so the size will be `5*5`).

```matlab
[H, keypoints, result] = harris(img, n, t);
```

The function takes a grayscale `img` and returns the matrix `H` of size `[h, w]`, the list of `keypoints` which consists of two columns (representing the indexes `i, j` of each corner pixel), and the image `result` obtained by overlaying the keypoints (represented as red pixels) over the input image.


### About
The algorithm used comes from the section 2.1 in the paper [Improving Harris corner selection strategy](https://digital-library.theiet.org/content/journals/10.1049/iet-cvi.2009.0127).
The LaTeX syntax in this file is rendered with [github-latex-markdown](https://alexanderrodin.com/github-latex-markdown/).
