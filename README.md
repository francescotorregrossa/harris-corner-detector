## Harris corner detector

Given an image ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;I(p)) where ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;p) represents the coordinates of a pixel, it's possible to detect if the local neighbourhood of ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;p) contains a corner by using the [Harris corner detector](https://en.wikipedia.org/wiki/Harris_Corner_Detector).

The standard implementation works by using the autocorrelation matrix

<p align="center">
<img src="https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Cmu%28p%29%20%3D%20%5Cbegin%7Bbmatrix%7D%20%5Csum_%7Bq%20%5Cin%20N%7D%20I_x%5E2%28q%29%20%26%20%5Csum_%7Bq%20%5Cin%20N%7D%20I_x%28q%29I_y%28q%29%20%5C%5C%20%5Csum_%7Bq%20%5Cin%20N%7D%20I_x%28q%29I_y%28q%29%20%26%20%5Csum_%7Bq%20%5Cin%20N%7D%20I_y%5E2%28q%29%20%5C%5C%20%5Cend%7Bbmatrix%7D" />
</p>

where ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;I_x) and ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;I_y) are the partial derivatives of ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;I). The determinant and the trace of this matrix are high respectively when there is a corner and when there is an edge or corner. Thus, we can define the matrix ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;H(p)) such that ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;H(p)&space;\gg&space;0) when there is a corner and ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;H(p)&space;\ll&space;0) when there is an edge as
<p align="center">
<img src="https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20H%28p%29%20%3D%20%5Cdet%28%5Cmu%28p%29%29%20-%20k%20%5Cmathrm%7Btr%7D%5E2%28%5Cmu%28p%29%29" />
</p>

with a normalisation factor ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;k) which is typically in the range ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;[0.04,&space;0.16]).

We can then define a corner as a point ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;p) in ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;H(p)) such that ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;p) is a local maximum and that ![](https://latex.codecogs.com/gif.latex?\inline&space;\dpi{120}&space;H(p)&space;>&space;t&space;>&space;0).



### Implementation and usage

This implementation has a fixed value for `k = 0.04` and takes `t` and `n` as parameters, where `n` represents the size of the window in which to perform the operations (e.g. if `p` is the center of the window and `n = 2`, then the window will go from `p-2` to `p+2` in both directions, so the size will be `5*5`).

```matlab
[H, keypoints, result] = harris(img, n, t);
```

The function takes a grayscale `img` and returns the matrix `H` of size `[h, w]`, the list of `keypoints` which consists of two columns (representing the indexes `i, j` of each corner pixel), and the image `result` obtained by overlaying the keypoints (represented as red pixels) over the input image.
