# Use the official Go image as the build environment
FROM golang:1.16 AS builder

# Set the working directory
WORKDIR /app

# Copy Go module files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the executable file
RUN CGO_ENABLED=0 GOOS=linux go build -o custom-scheduler .

# Use a slim Debian image as the final runtime environment
FROM debian:stretch-slim

# Set the working directory
WORKDIR /

# Copy the executable file from the build stage to the final image
COPY --from=builder /app/custom-scheduler /usr/local/bin

# Set the default command to run when the container starts
CMD ["custom-scheduler"]
