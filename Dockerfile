# much simplified dockerfile from https://github.com/cheptsov/wiki
FROM golang:1.8.1
RUN go get -u -v github.com/derekparker/delve/cmd/dlv

RUN mkdir -p /app
ADD . /app/
WORKDIR /app
RUN go build -o main .

# Port 8080 belongs to our application, 40000 belongs to Delve
EXPOSE 8080 40000

# Run delve
#CMD ["/dlv", "--listen=:40000", "--headless=true", "--log", "--backend=native", "exec", "/server"]

CMD ["dlv", "--listen=0.0.0.0:40000", "--headless=true", "--log", "--backend=native", "exec", "/app/main", "--"]