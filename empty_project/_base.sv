{% block comment_header %}// ----------------------------------------------------------------------------
// Author:                 {{ project.author }}
// Email:                  {{ project.email }}
// FileName:               kvt_{{ project.name }}{{ project.file }}.sv
// Create date:            {{ project.date }}
// Company:                {{ project.company }}
// ----------------------------------------------------------------------------
{% endblock %}
`ifndef INC_KVT_{{ project.name|upper }}{{ project.file|upper }}
    `define INC_KVT_{{ project.name|upper }}{{ project.file|upper }}
    {% block body %}
    {% endblock %}
`endif // INC_KVT_{{ project.name|upper }}{{ project.file|upper }}
