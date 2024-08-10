FROM golang:1.23 as new

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

#second stage

FROM gcr.io/distroless/base

COPY --from=new /app/main .

COPY --from=new /app/static ./static

EXPOSE 8080

CMD ["./main"]
