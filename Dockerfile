FROM --platform=$BUILDPLATFORM golang:1.22 AS builder

WORKDIR /src

COPY go.mod go.sum main.go .
RUN --mount=type=cache,target=/go/pkg \
    go mod download

COPY . .

ARG TARGETOS TARGETARCH
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg \
    CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH \
    go build -o /go/bin/netpol-terminator .

# STEP 2: Build small image
FROM gcr.io/distroless/static-debian12
COPY --from=builder --chown=root:root /go/bin/netpol-terminator /bin/netpol

CMD ["/bin/netpol-terminator"]
