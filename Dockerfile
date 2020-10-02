FROM golang:alpine AS tester
WORKDIR /
COPY main.go .
COPY main_test.go .
RUN CGO_ENABLED=0 GOOS=linux go test -v 


FROM golang:alpine AS builder
COPY --from=tester main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o backend .


FROM scratch as runner
COPY --from=builder /go/backend backend
ENTRYPOINT ["/backend"]
EXPOSE 8080










