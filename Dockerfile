# Build stage
FROM golang:1.21-alpine3.18 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk add curl --no-cache curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.14.1/migrate.linux-amd64.tar.gz | tar xvz
RUN mv migrate.linux-amd64 /app/migrate

# Run stage
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate .
COPY app.env .
COPY start.sh .
COPY wait-for .
COPY db/migration ./migration

# Tambahkan perintah ini untuk memberikan izin eksekusi pada start.sh
RUN chmod +x /app/start.sh

USER myuser

EXPOSE 8080
CMD ["/app/main"]
ENTRYPOINT ["/app/start.sh"]
