FROM alpine AS source
RUN apk add --no-cache git
RUN git clone https://github.com/cloudflare/cloudflared.git --depth=1 /src

ARG TARGET_GOOS
ARG TARGET_GOARCH
FROM golang:1.26.3 AS builder
ARG TARGET_GOOS
ARG TARGET_GOARCH
ENV GO111MODULE=on \
  CGO_ENABLED=0 \
  TARGET_GOOS=${TARGET_GOOS} \
  TARGET_GOARCH=${TARGET_GOARCH} \
  CONTAINER_BUILD=1

WORKDIR /go/src/github.com/cloudflare/cloudflared/

COPY --from=source /src .

RUN make cloudflared

FROM gcr.io/distroless/base-debian13:nonroot

LABEL org.opencontainers.image.source="https://github.com/cloudflare/cloudflared"

COPY --from=builder --chown=nonroot /go/src/github.com/cloudflare/cloudflared/cloudflared /usr/local/bin/

USER 65532:65532

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
