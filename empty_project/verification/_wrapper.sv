{% extends "_base.sv" %}
{% block body %}
    module kvt_{{ project.name }}_wrapper(kvt_{{ project.name }}_env_if {{ project.name }}_env_if);

    // {{ project.name }} instance

    endmodule : kvt_{{ project.name }}_wrapper
{% endblock %}
