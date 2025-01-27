FROM eclipse-temurin:11

COPY --from=metabase/metabase:v0.52.7 /app /app

RUN useradd -ms /bin/sh metabase && chown -R metabase /app
WORKDIR /app
USER metabase

ENTRYPOINT ["/app/run_metabase.sh"]
# https://github.com/metabase/metabase/issues/13119#issuecomment-1502042436