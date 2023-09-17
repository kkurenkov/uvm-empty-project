{% extends "_base.sv" %}
{% block body %}
    interface kvt_{{ project.name }}_env_if();

        //  Clock and the reset.
        // -------------------- //
        kvt_clk_if {{ project.name }}_clk_if ();
        kvt_rst_if {{ project.name }}_rstn_if({{ project.name }}_clk_if.clk);

        // Other Interface
        // -------------------- //

    endinterface
{% endblock %}
