FROM caddy:builder AS builder

# Build a custom Caddy binary with the nginx adapter and Cloudflare DNS provider.
# Buildx will handle cross‑compilation so we don't need to set GOARCH here.
RUN xcaddy build \
    --with github.com/caddyserver/nginx-adapter \
    --with github.com/caddy-dns/cloudflare

# Final image uses the official Caddy runtime image.
FROM caddy:latest

# Copy the custom Caddy binary from the builder stage into the final image.
COPY --from=builder /usr/bin/caddy /usr/bin/caddy