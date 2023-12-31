{{- define "geek-cookbook.common.classes.serviceMonitor" -}}
{{- $values := dict -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.serviceMonitor -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}

{{- $serviceMonitorName := include "geek-cookbook.common.names.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- $serviceMonitorName = printf "%v-%v" $serviceMonitorName $values.nameOverride -}}
{{ end -}}
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: {{ $serviceMonitorName }}
  {{- with (merge ($values.labels | default dict) (include "geek-cookbook.common.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "geek-cookbook.common.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  selector:
    matchLabels:
      app.kubernetes.io/service: {{ $values.serviceName }}
      {{- include "geek-cookbook.common.labels.selectorLabels" . | nindent 6 }}
  endpoints: {{- toYaml (required (printf "endpoints are required for serviceMonitor %v" $serviceMonitorName) $values.endpoints) | nindent 4 }}
{{- end }}
