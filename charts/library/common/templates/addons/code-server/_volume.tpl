{{/*
The volume (referencing git deploykey) to be inserted into additionalVolumes.
*/}}
{{- define "geek-cookbook.common.addon.codeserver.deployKeyVolumeSpec" -}}
{{- if or .Values.addons.codeserver.git.deployKey .Values.addons.codeserver.git.deployKeyBase64 .Values.addons.codeserver.git.deployKeySecret }}
secret:
  {{- if .Values.addons.codeserver.git.deployKeySecret }}
  secretName: {{ .Values.addons.codeserver.git.deployKeySecret }}
  {{- else }}
  secretName: {{ include "geek-cookbook.common.names.fullname" . }}-deploykey
  {{- end }}
  defaultMode: {{ "0400" | toDecimal }}
  items:
    - key: id_rsa
      path: id_rsa
{{- end -}}
{{- end -}}
