FROM alpine:3.23.3

ARG POSTGRES_VERSION=18

RUN apk update \
    && apk --no-cache add bash dumb-init postgresql${POSTGRES_VERSION}-client curl aws-cli supercronic

ENV POSTGRES_DATABASE=""
ENV POSTGRES_HOST=""
ENV POSTGRES_PORT=5432
ENV POSTGRES_USER=""
ENV POSTGRES_PASSWORD=""
ENV POSTGRES_EXTRA_OPTS ''
ENV S3_ACCESS_KEY_ID=""
ENV S3_SECRET_ACCESS_KEY=""
ENV S3_BUCKET=""
ENV S3_REGION us-west-1
ENV S3_PATH 'backup'
ENV S3_ENDPOINT=""
ENV S3_S3V4=no
ENV SCHEDULE=""
ENV SUCCESS_WEBHOOK=""

COPY --chmod=0775 entrypoint.sh .
COPY --chmod=0775 backup.sh .

HEALTHCHECK CMD curl --fail http://localhost:9746/health || exit 1

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "entrypoint.sh"]
