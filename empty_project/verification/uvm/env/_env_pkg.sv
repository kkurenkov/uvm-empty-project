{% extends "_base.sv" %}
{% block body %}
    `include "kvt_clk_rst_pkg.sv"

    `include "kvt_{{ project.name }}_define.sv"
    `include "kvt_{{ project.name }}_env_if.sv"

    package kvt_{{ project.name }}_env_pkg;
        import kvt_clk_rst_pkg::*;
        /** Import UVM Base Package */
        import uvm_pkg::*;

        `include "kvt_{{ project.name }}_env_cfg.sv"
        // `include "kvt_{{ project.name }}_scoreboard.sv"
        `include "kvt_{{ project.name }}_env.sv"

    endpackage :  kvt_{{ project.name }}_env_pkg
{% endblock %}
