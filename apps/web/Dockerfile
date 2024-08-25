# syntax=docker/dockerfile:1

ARG NODE_VERSION=20.11.1
ARG PNPM_VERSION=9.1.4
ARG PROJECT=web

# 1. Alpine image
FROM node:${NODE_VERSION}-alpine AS alpine
RUN apk update
RUN apk add --no-cache libc6-compat

# Setup pnpm and turbo on the alpine base
FROM alpine AS base
RUN corepack enable
RUN npm install turbo --global
RUN pnpm config set store-dir ~/.pnpm-store

# 2. Prune projects
FROM base AS pruner
ARG PROJECT

WORKDIR /app
COPY . .
RUN turbo prune --scope=${PROJECT} --docker

# 3. Build the project
FROM base AS builder
ARG PROJECT

WORKDIR /app

# Copy lockfile and package.json's of isolated subworkspace
COPY --from=pruner /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=pruner /app/out/pnpm-workspace.yaml ./pnpm-workspace.yaml
COPY --from=pruner /app/out/json/ .

# # First install the dependencies (as they change less often)
RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm install --frozen-lockfile

# Copy source code of isolated subworkspace
COPY --from=pruner /app/out/full/ .

RUN turbo build --filter=${PROJECT}

# This is a workaround to remove the node_modules with all dependencies and re-install only the production dependencies, because prune don't work well in monorepo, see: https://pnpm.io/cli/prune
RUN rm -rf **/node_modules
# This is a workaround to remove the source code of the isolated subworkspace, because we don't need it anymore
RUN rm -rf apps/${PROJECT}/app apps/${PROJECT}/public

RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm install --frozen-lockfile --prod

# 4. Final image - runner stage to run the application
FROM base AS runner
ARG PROJECT

WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 web
USER web

COPY --from=builder --chown=nodejs:web /app .

WORKDIR /app/apps/${PROJECT}

EXPOSE 3000

CMD ["pnpm", "start"]
