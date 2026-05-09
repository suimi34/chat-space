# Faraday 2+ has no default HTTP adapter; google-cloud-* expects one to be set.
require "faraday"
require "faraday/net_http"

Faraday.default_adapter = :net_http
