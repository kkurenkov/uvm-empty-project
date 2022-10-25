// ----------------------------------------------------------------------------
// Author:   Konstantin Kurenkov
// Email:    krendkrend@gmail.com
// Create date: 19/10/2022
// FileName: kvt_base_report_catcher.sv
//
// ----------------------------------------------------------------------------

`ifndef INC_KVT_BASE_REPORT_CATCHER
`define INC_KVT_BASE_REPORT_CATCHER

    typedef enum {BLACK,
                  RED,
                  GREEN,
                  YELLOW,
                  BLUE,
                  MAGENTA,
                  CYAN,
                  WHITE,
                  GRAY,
                  NO_COLOR
    } color_t;

    string font_format[color_t] = '{BLACK  :"\033[30m%s\033[0m",
                                    RED    :"\033[31m%s\033[0m",
                                    GREEN  :"\033[32m%s\033[0m",
                                    YELLOW :"\033[33m%s\033[0m",
                                    BLUE   :"\033[34m%s\033[0m",
                                    MAGENTA:"\033[35m%s\033[0m",
                                    CYAN   :"\033[36m%s\033[0m",
                                    WHITE  :"\033[37m%s\033[0m",
                                    GRAY   :"\033[90m%s\033[0m"
                                  };

    string bg_format[color_t]   = '{BLACK  :"\033[40m%s\033[0m",
                                    RED    :"\033[41m%s\033[0m",
                                    GREEN  :"\033[42m%s\033[0m",
                                    YELLOW :"\033[43m%s\033[0m",
                                    BLUE   :"\033[44m%s\033[0m",
                                    MAGENTA:"\033[45m%s\033[0m",
                                    CYAN   :"\033[46m%s\033[0m",
                                    WHITE  :"\033[47m%s\033[0m",
                                    GRAY   :"\033[100m%s\033[0m",
                                    NO_COLOR:"\033[49m%s\033[0m"
                                  };

class kvt_base_report_catcher extends uvm_report_catcher;

    local string      format_string;

    integer           fiber;
    integer           handler;

    color_t           font_color;
    color_t           bg_color;

    function new(string name="kvt_base_report_catcher", color_t f_c = GREEN, color_t b_c = NO_COLOR);
        super.new(name);
        font_color = f_c;
        bg_color   = b_c;
        $sformat(format_string, bg_format[bg_color], font_format[font_color]);
    endfunction : new

    // -------------------------------------------------------------------------
    //  set_colors
    // -------------------------------------------------------------------------
    function void set_colors(color_t f_c = GREEN, color_t b_c = NO_COLOR);
        font_color = f_c;
        bg_color   = b_c;
    endfunction : set_colors

    // -------------------------------------------------------------------------
    //  catch
    // -------------------------------------------------------------------------
    function action_e catch();
        string       msg  = get_message();
        string       tag  = get_id();
        uvm_severity svrt = get_severity();

        // Set default colors
        $sformat(format_string, bg_format[bg_color], font_format[font_color]);

        // change colors according with severity
        if( (svrt == UVM_ERROR) || (svrt == UVM_FATAL) ) begin
                $sformat(format_string, bg_format[NO_COLOR], font_format[RED]);
        end else if (svrt == UVM_WARNING) begin
                $sformat(format_string, bg_format[NO_COLOR], font_format[BLUE]);
        end else if (tag.substr(0,2) == "TB/") begin
                $sformat(format_string, bg_format[NO_COLOR], font_format[MAGENTA]);
            end

        $sformat(msg, format_string, msg);
        set_message(msg);
        return THROW;
    endfunction : catch

endclass : kvt_base_report_catcher

`endif // INC_KVT_BASE_REPORT_CATCHER
