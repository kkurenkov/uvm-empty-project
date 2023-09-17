{% extends "_base.sv" %}
{% block body %}
    `include "kvt_{{ project.name }}_env_pkg.sv"

    package kvt_{{ project.name }}_test_pkg;
        /** Import UVM Base Package */
        import uvm_pkg::*;
        import kvt_{{ project.name }}_env_pkg::*;

        `include "kvt_{{ project.name }}_base_report_catcher.sv"
        `include "kvt_{{ project.name }}_base_test.sv"
    endpackage :  kvt_{{ project.name }}_test_pkg
    
{% endblock %}