## aws-signing-proxy
FROM golang:1.20 AS build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -mod=mod -o aws-signing-proxy main.go


### Use alpine instead of scratch so that we can use /bin/sh
FROM alpine
MAINTAINER Chris Lunsford <cllunsford@gmail.com>

# Add ca-certificates.crt for https
ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Add executable
COPY --from=build /app/aws-signing-proxy /usr/local/bin/

# Default listening port
EXPOSE 8080

ENTRYPOINT ["/aws-signing-proxy"]
