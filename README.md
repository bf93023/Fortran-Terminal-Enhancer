# Color-Utilities
The `color_utils_mod` module provides utilities for handling ANSI escape codes for text formatting in terminal outputs. It includes parameters for various text and background colors, text styles, and functions to initialize and print colored text.

## Features

- Supports multiple text and background colors.
- Supports various text styles like bold, italic, underline, etc.
- Enables and disables ANSI escape codes based on environment.

## Usage

```fortran
! Initialize colors (optional):
call initialize_colors(.true.)

! Print colored text:
call print_colored('Hello, World!', RED)
call print_colored('Warning!', YELLOW, 10)