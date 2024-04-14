# Use an official Go runtime as a parent image
FROM golang:1.20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the Go Modules manifests and the rest of the source code
COPY go.mod go.sum ./
COPY .env /app/.env
COPY . .

# Disable crosscompiling 
ENV CGO_ENABLED=0

# Compile Linux only
ENV GOOS=linux
# No need for C libraries
ENV GOARCH=amd64

# Download necessary Go modules
RUN go mod tidy
RUN go mod download

# Build the Go app
RUN go build -o /gpt-wework .

# Run the binary program produced by ‘go install’
CMD ["/gpt-wework"]
