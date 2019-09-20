# build stage

#FROM golang:alpine as builder

#COPY . /go/src/github.com/bharath0080/concourse-ssh-resource

#RUN apk --no-cache add make && \
#  cd /go/src/github.com/bharath0080/concourse-ssh-resource && \
#  make build-linux

#WORKDIR /opt/resource

# release stage

#FROM alpine:edge

#COPY --from=builder /opt/resource /opt/resource

# build stage

FROM golang:alpine as builder

RUN apk --no-cache add make && apk add --no-cache git
#
RUN  git clone https://github.com/bharath0080/concourse-ssh-resource.git && \
      cd concourse-ssh-resource && \
      	 make build-linux


WORKDIR /opt/resource
# release stage
FROM alpine:edge
COPY --from=builder /opt/resource /opt/resource
