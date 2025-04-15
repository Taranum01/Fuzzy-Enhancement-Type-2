# Fuzzy Image Enhancement Type 2

This project implements a fuzzy logic-based image denoising and enhancement method (Fuzzy Enhancement Type 2), specifically designed for handling noisy images, such as those found in underwater infrared datasets. The method uses a fuzzy inference system to reduce salt-and-pepper noise and improve image quality.

## Features

- **Fuzzy Denoising and Enhancement**: Enhances images by removing salt-and-pepper noise using fuzzy logic and Gaussian membership functions.
- **Type-2 Fuzzy Logic**: Uses Type-2 fuzzy logic for handling uncertainty in pixel values, particularly in noisy environments.
- **Edge-Preserving**: The method focuses on preserving important image features and edges while removing noise.
- **Underwater Infrared Dataset**: Specifically designed for images with underwater infrared characteristics, which tend to have poor visibility and high levels of noise.
- **Evaluation**: Performance evaluated with PSNR (Peak Signal-to-Noise Ratio).

## Prerequisites

Ensure you have the following dependencies installed:

- MATLAB (or GNU Octave)
- Image Processing Toolbox (for `imread`, `imshow`, etc.)
