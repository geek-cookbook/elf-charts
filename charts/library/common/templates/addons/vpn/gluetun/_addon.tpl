{{/*
Template to render gluetun addon. It will add the container to the list of additionalContainers.
*/}}
*/}}
{{- define "geek-cookbook.common.addon.gluetun" -}}
  {{/* Append the gluetun container to the additionalContainers */}}
  {{- $container := fromYaml (include "geek-cookbook.common.addon.gluetun.container" .) -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-gluetun" $container -}}
  {{- end -}}
{{- end -}}
