{{/*
Define metadata used by all objects.
*/}}
{{- define "universal.metadata" }}
metadata:
  name: {{ .name }}
  labels: {{ include "common.labels.standard" (dict "customLabels" .context.Values.commonLabels "context" .context) | nindent 4 }}
    "app.kubernetes.io/version": {{ default .context.Chart.Version .context.Values.version | quote}}
    {{- range $key, $value := ( .metadata.labels | default (list)) }}
    {{ $key | quote }}: {{ $value | quote }}
    {{- end }}{{- /* end of labels*/}}
  annotations:
    {{- range $key, $value := ( .metadata.annotations | default (list)) }}
    {{ $key | quote }}: {{ $value | quote }}
    {{- end }}{{- /* end of annotations*/}}
{{- end }}{{- /* end of universal.metadata*/}}


{{/*
Universal object with base data for all objects (pods, services, etc.)
*/}}
{{- define "universal.object" }}
apiVersion: {{ default .apiVersion "v1" }}
kind: {{ .kind }}
{{- include "universal.metadata" (dict "name" .name "metadata" .metadata "context" .context) }}
{{- end }}
