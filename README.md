# Fuzzy Image, GIF, and Video Enhancement using Type-2 Fuzzy Logic

This project implements a **Type-2 fuzzy logic-based image denoising and enhancement method**, specifically designed for handling noisy visual content—including **images**, **GIFs**, and **videos**. The method is particularly effective for salt-and-pepper noise and is tested on challenging datasets such as **underwater infrared imagery**.

## Features

- 🧠 **Fuzzy Denoising and Enhancement**  
  Uses fuzzy logic and Gaussian membership functions to suppress **salt-and-pepper noise** and enhance overall image quality.

- 🔄 **Multi-Format Input Support**  
  Works with static **images**, animated **GIFs**, and video files, adapting the processing pipeline accordingly.

- 🌫️ **Type-2 Fuzzy Logic**  
  Leverages Type-2 fuzzy systems to model uncertainty in noisy pixel values, making it more robust in unpredictable environments.

- 🖼️ **Edge-Preserving Filtering**  
  Carefully removes noise without damaging crucial edges or image structures.

- 🌊 **Underwater Infrared Dataset Ready**  
  Tailored for environments with **low visibility**, such as infrared underwater footage, where traditional methods fall short.

- 📈 **Performance Evaluation**  
  Enhancement results are quantitatively assessed using:
  - PSNR (Peak Signal-to-Noise Ratio)

## Prerequisites

Ensure you have the following dependencies installed:

- MATLAB (or compatible: **GNU Octave**)
- Image Processing Toolbox (`imread`, `imshow`, etc.)

## Input Options

You can select your input type during runtime:

- **Image**: Standard image files (`.jpg`, `.png`, etc.)
- **GIF**: Animated `.gif` files
- **Video**: `.mp4`, `.avi`, etc.

## Usage

1. Open the script in MATLAB or Octave.
2. Run the script and follow the dialog prompts to choose an input type.
3. The enhanced output will be displayed and can be saved as needed.

---

📌 **Note:** This project uses **Type-2 fuzzy inference** for denoising, making it ideal for edge-sensitive and noise-heavy image enhancement applications.
