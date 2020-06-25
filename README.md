# ImageSteganography
Image Steganography using LSB Technique implemented in MATLAB

### About
Image steganography refers to process of hiding messages in images with minimal distortion to the image which is invisible to the naked eye. This implementation is based on LSB technique wherein the least signifact value of each color value is changed.

### Password Protection
Instead of writing message in a linear fashion, we take in a string key as input and generate a number array from it which dictates the order of writing bits in the image. With this our message is protected even though our implementation details are public.

## Usage
- Run ```encode.m``` and enter name of the image, key, message and output image name. Avoid using compressed image format such as ```.jpg```.
- To retreive the message, run ```decode.m``` and enter the image name and the key. Incorrect key will lead to a garbage output.

Created by: [Rohit Agarwal](https://github.com/rohitagarwal0910) and [Shashank Goyal](https://github.com/shango9947)
