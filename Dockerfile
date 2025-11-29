FROM andrescv/jupiter:latest
RUN mkdir -p /data
ENTRYPOINT ["/usr/bin/jupiter", "/data/riscv5.s"]