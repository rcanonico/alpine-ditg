FROM prantlf/alpine-make-gcc:latest as builder
RUN cd /root && \
    wget --no-check-certificate https://traffic.comics.unina.it/software/ITG/codice/D-ITG-2.8.1-r1023-src.zip && \
    unzip D-ITG-2.8.1-r1023-src.zip && \
    cd D-ITG-2.8.1-r1023/src && \
    wget -O unix.mk.patch https://github.com/rcanonico/alpine-ditg/raw/main/unix.mk.patch && \
    patch unix.mk unix.mk.patch && \
    make

FROM alpine:latest
COPY --from=builder /root/D-ITG-2.8.1-r1023/bin /usr/bin/
