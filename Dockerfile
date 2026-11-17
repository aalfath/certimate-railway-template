# Certimate, packaged for Railway.
# Upstream image: https://hub.docker.com/r/certimate/certimate (v0.4.38, multi-arch index digest)
FROM certimate/certimate:v0.4.38@sha256:175193844f59de2ea187b13c2f81ce23c1410dd6af0630a9e6434d1498a6e33b

COPY start.sh /app/start.sh
RUN chmod 0755 /app/start.sh

# All state (SQLite database, settings, certificates, logs) lives in /app/pb_data.
# On Railway a volume is mounted there (Railway does not allow the Dockerfile VOLUME keyword).

ENV PORT=8090
EXPOSE 8090

ENTRYPOINT ["/app/start.sh"]
