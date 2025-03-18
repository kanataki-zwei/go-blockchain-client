# Use official Golang image to build the binary
FROM golang:1.24 AS builder

WORKDIR /app

# Copy go.mod and go.sum first to cache dependencies
COPY go.mod go.sum ./
RUN go mod tidy

# Copy the entire project
COPY . .

# Build for Linux (important for macOS users)
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o blockchain-client .

# Use minimal Alpine image for the final container
FROM alpine:latest

WORKDIR /root/

# Install required libraries
RUN apk add --no-cache ca-certificates libc6-compat

# Copy the built binary from the builder stage
COPY --from=builder /app/blockchain-client .

# Ensure the binary is executable
RUN chmod +x /root/blockchain-client

# Expose the correct port
EXPOSE 9090

# Run the application
CMD ["/root/blockchain-client"]
