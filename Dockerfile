FROM golang:1.22.5-alpine AS base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

#build the application
RUN go build -o main .

#final stage-distroless image creation
FROM gcr.io/distroless/base-debian11

COPY --from=base /app/main .

#copying static files and content
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]




