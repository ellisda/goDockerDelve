# Compile stage
# FROM golang:1.10.1-alpine3.7 AS build-env
FROM golang:1.10.1-alpine3.7
ENV CGO_ENABLED 0
ADD . /go/src/myapp
 
# The -gcflags "all=-N -l" flag helps us get a better debug experience
RUN go build -gcflags "all=-N -l" -o /myapp myapp
 
# Compile Delve
RUN apk add --no-cache git
RUN go get github.com/derekparker/delve/cmd/dlv
 
# Final stage
# FROM alpine:3.7
 
# Port 8080 belongs to our application, 40000 belongs to Delve
EXPOSE 8080 40000
 
# Allow delve to run on Alpine based containers.
# RUN apk add --no-cache libc6-compat
 
WORKDIR /
 
# COPY --from=build-env /server /
# COPY --from=build-env /go/bin/dlv /

# Run delve
CMD ["/go/bin/dlv", "--listen=0.0.0.0:40000", "--headless=true", "--log", "--backend=native", "exec", "/myapp", "--"]