## aws-signing-proxy

### Use alpine instead of scratch so that we can use /bin/sh
FROM alpine
MAINTAINER Chris Lunsford <cllunsford@gmail.com>

# Add ca-certificates.crt for https
ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Add executable
ADD aws-signing-proxy /

# Default listening port
EXPOSE 8080

ENTRYPOINT ["/aws-signing-proxy"]
