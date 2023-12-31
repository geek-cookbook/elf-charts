{{/*
Blueprint for the NetworkPolicy object that can be included in the addon.
*/}}
{{- define "geek-cookbook.common.addon.vpn.networkpolicy" -}}
{{- if .Values.addons.vpn.networkPolicy.enabled }}
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: {{ include "geek-cookbook.common.names.fullname" . }}
  {{- with (merge (.Values.addons.vpn.networkPolicy.labels | default dict) (include "geek-cookbook.common.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge (.Values.addons.vpn.networkPolicy.annotations | default dict) (include "geek-cookbook.common.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  podSelector:
    {{- with (merge .Values.addons.vpn.networkPolicy.podSelectorLabels (include "geek-cookbook.common.labels.selectorLabels" . | fromYaml)) }}
    matchLabels: {{- toYaml . | nindent 6 }}
    {{- end }}
  policyTypes:
    - Egress
  egress:
    {{- with .Values.addons.vpn.networkPolicy.egress }}
      {{- . | toYaml | nindent 4 }}
    {{- end -}}
{{- end -}}
{{- end -}}
