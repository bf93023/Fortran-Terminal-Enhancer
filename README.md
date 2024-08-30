# Fort Colors Mod

`fort_colors_mod` is a Fortran module designed to enhance terminal output with colors, styles, and progress bars using ANSI escape codes. This module provides a set of utilities to format text with different colors, styles, alignments, and visual effects, making command-line outputs more visually appealing and easier to interpret. It also includes a progress bar feature for displaying task progress.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Usage](#usage)
  - [Initialize Colors](#initialize-colors)
  - [Print Styled Text](#print-styled-text)
  - [Print Bullet Points](#print-bullet-points)
  - [Display Progress Bar](#display-progress-bar)
- [Additional Styles](#additional-styles)
- [Example Program](#example-program)
- [Compatibility and Limitations](#compatibility-and-limitations)
- [License](#license)
- [Author](#author)
- [Contributing](#contributing)

## Features

- **Text Styling with ANSI Escape Codes**: Print text in various colors and styles (bold, italic, underline) using ANSI escape codes.
- **Background Colors**: Set background colors for text to enhance readability and emphasize important output.
- **Derived Type for Text Styling**: Use the `TextStyle` derived type to simplify styling and maintain consistency.
- **Preset Styles**: Several predefined styles like `TITLE_STYLE`, `ERROR_STYLE`, `CODE_STYLE`, etc., for common output needs.
- **Text Alignment and Indentation**: Supports left, center, and right alignment with customizable indentation.
- **Bullet Point Printing**: Print bullet points with customizable characters and indentation.
- **Progress Bar**: A simple, text-based progress bar to show task progress in the terminal.
- **ANSI Support Check**: Option to check if ANSI codes are supported by the terminal and disable them if necessary.
- **Enhanced Output**: Additional styles for informational, debugging, input prompts, highlighting, links, and more.

## Installation

To use the `fort_colors_mod` module, include the source file (`fort_colors_mod.f90`) in your Fortran project. You can compile your program along with the module using any Fortran compiler.

### Example Compilation

```bash
gfortran -o my_program fort_colors_mod.f90 my_program.f90
```

Replace `my_program.f90` with the name of your Fortran source file.

## Getting Started

To start using `fort_colors_mod`, follow these steps:

1. **Include the Module in Your Program**: Use the `use fort_colors_mod` statement to include the module.
2. **Initialize ANSI Color Support**: Call `initialize_colors()` to enable or disable ANSI color support based on terminal compatibility.
3. **Use Styling and Utility Subroutines**: Use the various subroutines provided to print styled text, bullet points, and progress bars.

## Usage

### Initialize Colors

Initialize ANSI color support to ensure your terminal supports it. This step is optional but recommended for ensuring compatibility.

```fortran
call initialize_colors(.true.)  ! Enable ANSI color support
```

### Print Styled Text

Use the `print_styled` subroutine to print text with a specific style. You can use predefined styles or define your own.

```fortran
call print_styled("Error: Unable to locate file!", ERROR_STYLE)
call print_styled("Welcome to the Program", TITLE_STYLE)
```

### Print Bullet Points

Print bullet points with customizable indentation and bullet characters using `print_bullet`.

```fortran
call print_bullet("First item")
call print_bullet("Second item", bullet_char="-", indent=2)
```

### Display Progress Bar

Show a progress bar to indicate task progress using `print_progress_bar`.

```fortran
do i = 1, 100
    call print_progress_bar(i, 100)
    call sleep(1)  ! Simulate work
end do
write(*,*)  ! Move to a new line after the progress bar
```

## Additional Styles

The module includes several additional styles for more advanced text formatting:

- **INFO_STYLE**: For general informational messages.
- **DEBUG_STYLE**: For debugging messages.
- **INPUT_PROMPT_STYLE**: For prompting user input.
- **HIGHLIGHT_STYLE**: For emphasizing important notes or key points.
- **LINK_STYLE**: For displaying clickable or hyperlinked text in supported terminals.
- **TITLE_HIGHLIGHT_STYLE**: For creating an emphasized title with a background color.
- **DISABLED_TEXT_STYLE**: For text that represents a disabled or inactive option.
- **SUBHEADING_STYLE**: A style for subheadings, distinct from the main heading style.
- **SHADOWED_TEXT_STYLE**: For text that should appear 'shadowed' or less emphasized.

These styles provide flexibility and allow you to customize your terminal output to suit your needs.

## Example Program

Below is a comprehensive example that demonstrates various features of the `fort_colors_mod` module.

```fortran
program test_colors
    use fort_colors_mod
    implicit none

    type(TextStyle) :: body_style
    integer :: i

    ! Initialize colors
    call initialize_colors(.true.)

    ! Simulate a program startup sequence
    call print_styled("=== Welcome to the Fort Colors Utility ===", TITLE_STYLE)
    call print_styled("Version 1.0.0", SUBTITLE_STYLE)
    call print_styled("Initializing components...", BODY_STYLE_CONST)

    ! Simulate loading configurations
    call print_styled("Loading configuration file: config.cfg", INFO_STYLE)
    call print_styled("Configuration loaded successfully.", SUCCESS_STYLE)

    ! Simulate checking system status
    call print_styled("Checking system status...", INFO_STYLE)
    call print_styled("Warning: Low disk space detected on drive C:.", WARNING_STYLE)
    call print_styled("Error: Unable to locate the backup drive.", ERROR_STYLE)

    ! Display a motivational quote for the user
    call print_styled("Tip of the Day: The only way to do great work is to love what you do. - Steve Jobs", QUOTE_STYLE)

    ! Simulate debugging information
    call print_styled("Debug: Entering the main processing loop...", DEBUG_STYLE)

    ! Simulate code output section
    call print_styled("Generating report...", BODY_STYLE_CONST)
    call print_styled("def generate_report():", CODE_STYLE)
    call print_styled("    print('Generating data...')", CODE_STYLE)
    call print_styled("    # Placeholder for actual report generation logic", CODE_STYLE)

    ! Simulate user input prompt
    call print_styled("Please enter the output directory: ", INPUT_PROMPT_STYLE)

    ! Displaying report headings and details
    call print_styled("=== Report Summary ===", HEADING_STYLE)
    call print_styled("Task Name: Data Analysis", BODY_STYLE_CONST)
    call print_styled("Status: Completed", SUCCESS_STYLE)
    call print_styled("Details:", BODY_STYLE_CONST)
    call print_bullet("Processed 1000 records", "*", 4)
    call print_bullet("Found 3 anomalies", "*", 4)

    ! Displaying additional notes or links
    call print_styled("For more information, visit the documentation at: ", BODY_STYLE_CONST)
    call print_styled("https://example.com/docs", LINK_STYLE)

    ! Highlight important information
    call print_styled("Important: Ensure all dependencies are installed before running.", HIGHLIGHT_STYLE)

    ! Simulate progress of a long-running operation
    call print_styled("Starting data cleanup operation...", BODY_STYLE_CONST)
    do i = 1, 100
        call print_progress_bar(i, 100)
        call sleep(1)  ! Simulate some work with a delay
    end do
    write(*,*)  ! Move to a new line after the progress bar
    call print_styled("Data cleanup operation completed successfully.", SUCCESS_STYLE)

    ! Display a title with background highlight
    call print_styled("=== Summary of Operations ===", TITLE_HIGHLIGHT_STYLE)

    ! Simulate displaying a disabled option
    call print_styled("Feature X: Disabled due to compatibility issues.", DISABLED_TEXT_STYLE)

    ! Simulate a subheading for additional section
    call print_styled("=== Next Steps ===", SUBHEADING_STYLE)
    call print_styled("1. Review the generated report for accuracy.", BODY_STYLE_CONST)
    call print_styled("2. Address any anomalies found during analysis.", BODY_STYLE_CONST)
    call print_styled("3. Backup the system and prepare for the next operation.", BODY_STYLE_CONST)

    ! Simulate footer or ending message
    call print_styled("Thank you for using Fort Colors Utility!", FOOTER_STYLE)
    call print_styled("=== End of Program ===", TITLE_STYLE)
end program test_colors
```

## Compatibility and Limitations

- **ANSI Escape Codes**: This module relies on ANSI escape codes for text styling, which may not be supported by all terminals. The module includes a check (`ansi_support` flag) to enable or disable ANSI colors based on terminal compatibility.
- **Progress Bar**: The progress bar uses carriage return (`\r`) to update the output in place. This may not work as expected in some terminal environments or text editors.
- **Terminal Width**: The `print_aligned` subroutine assumes a terminal width of 80 characters for centering and right-aligning text. Adjust the code if a different terminal width is required.

## License



This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

The `fort_colors_mod` module was originally written by Benjamin Ford, with enhancements for additional styling options and progress bar functionality.

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to improve the module.