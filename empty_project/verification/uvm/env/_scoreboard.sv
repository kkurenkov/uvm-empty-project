{% extends "_base.sv" %}
{% block body %}
    `uvm_analysis_imp_decl(_first)
    `uvm_analysis_imp_decl(_second)

    // Check analysis port connection
    `define CHECK_PORT_CONNECTION(PORT) \
        begin   \
            uvm_port_list list;  \
            PORT.get_provided_to(list);   \
            if (!list.size()) begin \
                `uvm_error("Scoreboard Analysis Port Connection",   \
                    $sformatf("Analysis port %s not connected", PORT.get_full_name())); \
            end \
            else begin  \
                `uvm_info("Scoreboard Analysis Port Connection",    \
                $sformatf("Analysis port %s is connected", PORT.get_full_name()),  \
                    UVM_LOW)    \
            end \
        end     \
        
    class kvt_{{ project.name }}_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(kvt_{{ project.name }}_scoreboard)

        // Port connected with the first agent
        uvm_analysis_imp_first #(kvt_{{ project.name }}_item, kvt_{{ project.name }}_scoreboard) input_port_first;
        // Port connected with the second agent      
        uvm_analysis_imp_second #(tvip_second_item, kvt_{{ project.name }}_scoreboard)           input_port_second;

        // Queue for data from the first analysis port        
        kvt_{{ project.name }}_item first_items[$];
        // Queue for data from the second analysis port 
        tvip_second_item            second_items[$];

        // User-defined variables
        int mismatch;
        int match;

        // Function/Tasks List
        // ----------------------------------------------------------------------------
        // Constructor
        // ----------------------------------------------------------------------------
        extern         function        new                     (string name = "kvt_{{ project.name }}_scoreboard",
                                                            uvm_component parent);
        // ----------------------------------------------------------------------------
        // Primary UVM functions/tasks
        // ----------------------------------------------------------------------------
        extern virtual function void   build_phase             (uvm_phase phase);
        extern virtual function void   end_of_elaboration_phase(uvm_phase phase);
        extern virtual function void   write_first             (kvt_{{ project.name }}_item pkt);
        extern virtual function void   write_second            (tvip_second_item pkt);
        extern virtual function void   check_phase             (uvm_phase phase);
        // ----------------------------------------------------------------------------
        // User-defined functions/tasks
        // ----------------------------------------------------------------------------
        extern virtual function void   check_transactions      ();
        extern virtual function void   handle_reset            ();

    endclass: kvt_{{ project.name }}_scoreboard


    // ----------------------------------------------------------------------------
    // Constructor
    // ----------------------------------------------------------------------------
    function kvt_{{ project.name }}_scoreboard::new(string name = "kvt_{{ project.name }}_scoreboard", 
                                                    uvm_component parent);
        super.new(name, parent);

    endfunction


    // ----------------------------------------------------------------------------
    // function build_phase
    // ----------------------------------------------------------------------------      
    function void kvt_{{ project.name }}_scoreboard::build_phase (uvm_phase phase);
        super.build_phase(phase);
        input_port_first  = new("input_port_first", this);
        input_port_second = new("input_port_second", this);

    endfunction : build_phase


    // ----------------------------------------------------------------------------
    // function end_of_elaboration
    // ---------------------------------------------------------------------------- 
    function void kvt_{{ project.name }}_scoreboard::end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        // If the component is enable, then
        `CHECK_PORT_CONNECTION(input_port_first)
        `CHECK_PORT_CONNECTION(input_port_second)

    endfunction: end_of_elaboration_phase


    // ----------------------------------------------------------------------------
    // function write_first
    // ---------------------------------------------------------------------------- 
    function void kvt_{{ project.name }}_scoreboard::write_first (kvt_{{ project.name }}_item pkt);
        first_items.push_back(pkt);
        check_transactions();

    endfunction : write_first


    // ----------------------------------------------------------------------------
    // function write_second
    // ---------------------------------------------------------------------------- 
    function void kvt_{{ project.name }}_scoreboard::write_second (tvip_second_item pkt);
        second_items.push_back(pkt);
        check_transactions();

    endfunction : write_second


    // ----------------------------------------------------------------------------
    // function check_transactions
    // ----------------------------------------------------------------------------       
    function void kvt_{{ project.name }}_scoreboard::check_transactions();
    
        if((second_items.size() > 0) && (first_items.size() > 0)) begin
            kvt_{{ project.name }}_item first_item  = new();
            kvt_{{ project.name }}_item second_item = new();

            if(first_item.data != second_item.data) begin 
                `uvm_error("SCB", $sformatf("data mismatch - exp: %0h, rcv: %0h", first_item.data, second_item.data))
                mismatch ++;
            end
            else match ++;
        end
        
    endfunction : check_transactions


    // ----------------------------------------------------------------------------
    // function handle_reset
    // ----------------------------------------------------------------------------  
    function void kvt_{{ project.name }}_scoreboard::handle_reset();
        // reset_happened_cg.sample(1);
        first_items .delete();
        second_items.delete();

    endfunction   


    // ----------------------------------------------------------------------------
    // function check_phase
    // ----------------------------------------------------------------------------         
    function void kvt_{{ project.name }}_scoreboard::check_phase (uvm_phase phase);
        super.check_phase(phase);

        assert(first_items.size() == 0) 
        else `uvm_error("SCOREBOARD", $sformatf("not all transaction ended! first_items.size() = %0h",
                            first_items.size()));
        assert(second_items.size() == 0) 
        else `uvm_error("SCOREBOARD", $sformatf("not all transaction ended! second_items.size() = %0h", 
                            second_items.size()));

    endfunction : check_phase
    
{% endblock %}

