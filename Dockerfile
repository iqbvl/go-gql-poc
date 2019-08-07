FROM golang:1.12 as goimage
ENV SRC=/go/src/
RUN mkdir -p /go/src/
WORKDIR /go/src/go-gql-poc
RUN git clone -b master — single-branch https://github.com/iqbvl/go-gql-poc /go/src/go-gql-poc/ \
&& CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -o bin/go-gql-poc
FROM alpine:3.6 as baseimagealp
RUN apk add — no-cache bash
ENV WORK_DIR=/docker/bin
WORKDIR $WORK_DIR
COPY — from=goimage /go/src/go-gql-poc/bin/ ./
ENTRYPOINT /docker/bin/go-gql-poc
EXPOSE 8080