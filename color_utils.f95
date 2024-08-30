module fort_colors_mod
    implicit none

    ! ANSI escape codes for text colors
    character(len=*), parameter :: RESET = char(27) // '[0m'
    character(len=*), parameter :: RED = char(27) // '[31m'
    character(len=*), parameter :: GREEN = char(27) // '[32m'
    character(len=*), parameter :: YELLOW = char(27) // '[33m'
    character(len=*), parameter :: BLUE = char(27) // '[34m'
    character(len=*), parameter :: MAGENTA = char(27) // '[35m'
    character(len=*), parameter :: CYAN = char(27) // '[36m'
    character(len=*), parameter :: WHITE = char(27) // '[37m'
    character(len=*), parameter :: BLACK = char(27) // '[30m'
    character(len=*), parameter :: BRIGHT_RED = char(27) // '[91m'
    character(len=*), parameter :: BRIGHT_GREEN = char(27) // '[92m'
    character(len=*), parameter :: BRIGHT_YELLOW = char(27) // '[93m'
    character(len=*), parameter :: BRIGHT_BLUE = char(27) // '[94m'
    character(len=*), parameter :: BRIGHT_MAGENTA = char(27) // '[95m'
    character(len=*), parameter :: BRIGHT_CYAN = char(27) // '[96m'
    character(len=*), parameter :: BRIGHT_WHITE = char(27) // '[97m'

    ! ANSI escape codes for background colors
    character(len=*), parameter :: BG_BLACK = char(27) // '[40m'
    character(len=*), parameter :: BG_RED = char(27) // '[41m'
    character(len=*), parameter :: BG_GREEN = char(27) // '[42m'
    character(len=*), parameter :: BG_YELLOW = char(27) // '[43m'
    character(len=*), parameter :: BG_BLUE = char(27) // '[44m'
    character(len=*), parameter :: BG_MAGENTA = char(27) // '[45m'
    character(len=*), parameter :: BG_CYAN = char(27) // '[46m'
    character(len=*), parameter :: BG_WHITE = char(27) // '[47m'
    character(len=*), parameter :: BG_BRIGHT_BLACK = char(27) // '[100m'
    character(len=*), parameter :: BG_BRIGHT_RED = char(27) // '[101m'
    character(len=*), parameter :: BG_BRIGHT_GREEN = char(27) // '[102m'
    character(len=*), parameter :: BG_BRIGHT_YELLOW = char(27) // '[103m'
    character(len=*), parameter :: BG_BRIGHT_BLUE = char(27) // '[104m'
    character(len=*), parameter :: BG_BRIGHT_MAGENTA = char(27) // '[105m'
    character(len=*), parameter :: BG_BRIGHT_CYAN = char(27) // '[106m'
    character(len=*), parameter :: BG_BRIGHT_WHITE = char(27) // '[107m'

    ! ANSI escape codes for text styles
    character(len=*), parameter :: BOLD = char(27) // '[1m'
    character(len=*), parameter :: DIM = char(27) // '[2m'
    character(len=*), parameter :: ITALIC = char(27) // '[3m'
    character(len=*), parameter :: UNDERLINE = char(27) // '[4m'
    character(len=*), parameter :: BLINK = char(27) // '[5m'
    character(len=*), parameter :: INVERSE = char(27) // '[7m'
    character(len=*), parameter :: HIDDEN = char(27) // '[8m'
    character(len=*), parameter :: STRIKETHROUGH = char(27) // '[9m'

    ! Flag to check if ANSI support is enabled
    logical :: ansi_support = .true.

    ! Define a derived type to store text style options
    type :: TextStyle
        character(len=10) :: color = "WHITE"
        character(len=15) :: bg_color = ""
        logical :: bold = .false.
        logical :: italic = .false.
        logical :: underline = .false.
        integer :: indent = 0
        character(len=10) :: alignment = "left"
    end type TextStyle

    ! Enhanced preset styles with distinct styling for code
    type(TextStyle), parameter :: TITLE_STYLE = TextStyle(color="BRIGHT_BLUE", &
        bg_color="", bold=.true., underline=.true., alignment="center")

    type(TextStyle), parameter :: SUBTITLE_STYLE = TextStyle(color="BRIGHT_MAGENTA", &
        bg_color="", bold=.true., alignment="center")

    type(TextStyle), parameter :: HEADING_STYLE = TextStyle(color="BRIGHT_GREEN", &
        bg_color="", bold=.true., alignment="left")

    type(TextStyle), parameter :: BODY_STYLE_CONST = TextStyle(color="WHITE", &
        bg_color="", alignment="left")

    type(TextStyle), parameter :: BULLET_STYLE = TextStyle(color="CYAN", &
        bg_color="", alignment="left", indent=4)

    ! Additional styles
    type(TextStyle), parameter :: ERROR_STYLE = TextStyle(color="BRIGHT_RED", &
        bg_color="", bold=.true., alignment="left")

    type(TextStyle), parameter :: WARNING_STYLE = TextStyle(color="YELLOW", &
        bg_color="", bold=.true., alignment="left")

    type(TextStyle), parameter :: SUCCESS_STYLE = TextStyle(color="BRIGHT_GREEN", &
        bg_color="", bold=.true., alignment="left")

    type(TextStyle), parameter :: QUOTE_STYLE = TextStyle(color="MAGENTA", &
        bg_color="", italic=.true., alignment="left", indent=2)

    ! Enhanced CODE_STYLE with background color and dim text
    type(TextStyle), parameter :: CODE_STYLE = TextStyle(color="WHITE", &
        bg_color="BG_BRIGHT_BLACK", bold=.false., italic=.false., alignment="left", indent=4)

    type(TextStyle), parameter :: FOOTER_STYLE = TextStyle(color="BRIGHT_CYAN", &
        bg_color="", bold=.false., alignment="center")

contains

    subroutine initialize_colors(enable_colors)
        implicit none
        logical, intent(in), optional :: enable_colors

        ! Set ANSI support based on the optional input
        if (present(enable_colors)) then
            ansi_support = enable_colors
        end if
    end subroutine initialize_colors

    subroutine print_styled(text, style)
        implicit none
        character(len=*), intent(in) :: text
        type(TextStyle), intent(in) :: style
        character(len=:), allocatable :: formatted_text

        ! Generate ANSI codes based on style
        if (ansi_support) then
            formatted_text = create_ansi_code(style) // trim(text) // RESET
        else
            formatted_text = trim(text)
        end if

        ! Apply alignment and indentation
        call print_aligned(formatted_text, style%alignment, style%indent)
    end subroutine print_styled

    function create_ansi_code(style) result(ansi_code)
        implicit none
        type(TextStyle), intent(in) :: style
        character(len=:), allocatable :: ansi_code
    
        ansi_code = ""
    
        ! Append color codes
        select case (trim(adjustl(style%color)))
            case ("RED")
                ansi_code = ansi_code // RED
            case ("GREEN")
                ansi_code = ansi_code // GREEN
            case ("YELLOW")
                ansi_code = ansi_code // YELLOW
            case ("BLUE")
                ansi_code = ansi_code // BLUE
            case ("MAGENTA")
                ansi_code = ansi_code // MAGENTA
            case ("CYAN")
                ansi_code = ansi_code // CYAN
            case ("WHITE")
                ansi_code = ansi_code // WHITE
            case ("BLACK")
                ansi_code = ansi_code // BLACK
            case ("BRIGHT_RED")
                ansi_code = ansi_code // BRIGHT_RED
            case ("BRIGHT_GREEN")
                ansi_code = ansi_code // BRIGHT_GREEN
            case ("BRIGHT_YELLOW")
                ansi_code = ansi_code // BRIGHT_YELLOW
            case ("BRIGHT_BLUE")
                ansi_code = ansi_code // BRIGHT_BLUE
            case ("BRIGHT_MAGENTA")
                ansi_code = ansi_code // BRIGHT_MAGENTA
            case ("BRIGHT_CYAN")
                ansi_code = ansi_code // BRIGHT_CYAN
            case ("BRIGHT_WHITE")
                ansi_code = ansi_code // BRIGHT_WHITE
            case default
                ansi_code = ansi_code // ""
        end select
    
        ! Append background color codes only if specified
        if (trim(style%bg_color) /= "") then
            select case (trim(adjustl(style%bg_color)))
                case ("BG_BLACK")
                    ansi_code = ansi_code // BG_BLACK
                case ("BG_RED")
                    ansi_code = ansi_code // BG_RED
                case ("BG_GREEN")
                    ansi_code = ansi_code // BG_GREEN
                case ("BG_YELLOW")
                    ansi_code = ansi_code // BG_YELLOW
                case ("BG_BLUE")
                    ansi_code = ansi_code // BG_BLUE
                case ("BG_MAGENTA")
                    ansi_code = ansi_code // BG_MAGENTA
                case ("BG_CYAN")
                    ansi_code = ansi_code // BG_CYAN
                case ("BG_WHITE")
                    ansi_code = ansi_code // BG_WHITE
                case ("BG_BRIGHT_BLACK")
                    ansi_code = ansi_code // BG_BRIGHT_BLACK
                case ("BG_BRIGHT_RED")
                    ansi_code = ansi_code // BG_BRIGHT_RED
                case ("BG_BRIGHT_GREEN")
                    ansi_code = ansi_code // BG_BRIGHT_GREEN
                case ("BG_BRIGHT_YELLOW")
                    ansi_code = ansi_code // BG_BRIGHT_YELLOW
                case ("BG_BRIGHT_BLUE")
                    ansi_code = ansi_code // BG_BRIGHT_BLUE
                case ("BG_BRIGHT_MAGENTA")
                    ansi_code = ansi_code // BG_BRIGHT_MAGENTA
                case ("BG_BRIGHT_CYAN")
                    ansi_code = ansi_code // BG_BRIGHT_CYAN
                case ("BG_BRIGHT_WHITE")
                    ansi_code = ansi_code // BG_BRIGHT_WHITE
                case default
                    ansi_code = ansi_code // ""
            end select
        end if
    
        ! Append style codes
        if (style%bold) ansi_code = ansi_code // BOLD
        if (style%italic) ansi_code = ansi_code // ITALIC
        if (style%underline) ansi_code = ansi_code // UNDERLINE
    end function create_ansi_code

    subroutine print_aligned(text, alignment, indent)
        implicit none
        character(len=*), intent(in) :: text
        character(len=*), intent(in) :: alignment
        integer, intent(in) :: indent
        integer :: text_len, padding

        text_len = len_trim(text)
        padding = max(0, indent)

        select case (alignment)
            case ("left")
                write(*, '(A)') repeat(' ', padding) // trim(text)
            case ("center")
                padding = (80 - text_len) / 2 + indent
                write(*, '(A)') repeat(' ', padding) // trim(text)
            case ("right")
                padding = 80 - text_len + indent
                write(*, '(A)') repeat(' ', padding) // trim(text)
        end select
    end subroutine print_aligned

    subroutine print_bullet(text, bullet_char, indent)
        implicit none
        character(len=*), intent(in) :: text
        character(len=1), intent(in), optional :: bullet_char
        integer, intent(in), optional :: indent
        character(len=1) :: bullet
        integer :: ind

        bullet = "*"
        if (present(bullet_char)) bullet = bullet_char
        ind = 4
        if (present(indent)) ind = indent

        write(*, '(A)') repeat(' ', ind) // bullet // " " // trim(text)
    end subroutine print_bullet

    subroutine print_progress_bar(current, total)
        implicit none
        integer, intent(in) :: current, total
        integer :: progress, i
        character(len=50) :: bar

        progress = int((real(current) / real(total)) * 50)
        bar = repeat('=', progress) // repeat(' ', 50 - progress)
        write(*, '(A)', advance="no") char(13)
        write(*, '(A, I3, A, A, A)', advance="no") "[", progress * 2, "%] [", trim(bar), "]"
        if (current < total) call flush(6)  ! Flush output to update the progress bar
    end subroutine print_progress_bar

end module fort_colors_mod

! Test the module
program test_colors
    use fort_colors_mod
    implicit none

    type(TextStyle) :: body_style
    integer :: i

    ! Initialize colors
    call initialize_colors(.true.)

    ! Test new preset styles
    call print_styled("Error: File not found!", ERROR_STYLE)
    call print_styled("Warning: Low disk space.", WARNING_STYLE)
    call print_styled("Success: Operation completed successfully.", SUCCESS_STYLE)
    call print_styled("The only way to do great work is to love what you do. - Steve Jobs", QUOTE_STYLE)
    call print_styled("def example_function():", CODE_STYLE)
    call print_styled("    print('Hello, World!')", CODE_STYLE)
    call print_styled("Footer: Thank you for using our software!", FOOTER_STYLE)

    ! Test the progress bar
    do i = 1, 100
        call print_progress_bar(i, 100)
        call sleep(1)  ! Simulate some work with a delay
    end do
    write(*,*)  ! Move to a new line after the progress bar

    ! Create a modifiable copy of BODY_STYLE for alignment changes
    body_style = BODY_STYLE_CONST

    ! Test alignment with body style
    call print_styled("Left aligned text", body_style)

    body_style%alignment = "center"
    call print_styled("Center aligned text", body_style)

    body_style%alignment = "right"
    call print_styled("Right aligned text", body_style)
end program test_colors
