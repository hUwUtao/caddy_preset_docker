# Multi‑architecture Caddy build with GitHub Actions

This repository contains a Dockerfile and GitHub Actions workflow for building a
custom Caddy server that includes the [nginx adapter](https://github.com/caddyserver/nginx-adapter)
and the [Cloudflare DNS provider](https://github.com/caddy-dns/cloudflare).  The
workflow uses Docker Buildx to build and publish a multi‑architecture image
targeting **amd64** and **arm64** platforms.

## Files

- **Dockerfile** – Defines a multi‑stage build that compiles a custom Caddy
  binary using `xcaddy` and packages it in the official Caddy runtime image.
- **.github/workflows/docker‑publish.yml** – A GitHub Actions workflow that runs
  on pushes and pull requests to the `main` branch.  It performs the following
  steps:

  1. Checks out the repository.
  2. Sets up QEMU for ARM emulation.
  3. Sets up Docker Buildx.
  4. Logs in to the GitHub Container Registry (GHCR) using the built‑in
     `${{ github.actor }}` and `${{ secrets.GITHUB_TOKEN }}`.  You can
     customise this step if you prefer to publish to Docker Hub or another
     registry.
  5. Builds and pushes the Docker image for both `linux/amd64` and
     `linux/arm64`.

## Publishing

By default, the workflow publishes the image to GHCR at
`ghcr.io/<owner>/<repo>:latest`.  If you wish to publish to Docker Hub or
another registry, modify the `REGISTRY` and `tags` values in
`.github/workflows/docker‑publish.yml` and set appropriate secrets (e.g.
`DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`) in your repository settings.

## Prerequisites

* A GitHub repository containing this project.
* If publishing to a registry other than GHCR, store your registry
  credentials as secrets in your GitHub repository and update the workflow
  accordingly.

## Usage

1. Push this repository to GitHub.
2. Ensure the `main` branch exists.
3. On each push to `main` (or pull request against `main`), the workflow will
   build the Docker image for amd64 and arm64 and publish it to the registry.
4. Pull the image using `docker pull ghcr.io/<owner>/<repo>:latest` (or the
   appropriate tag).