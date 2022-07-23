FROM ubuntu:20.04 AS deps

ARG BOOST_VERSION=1.75.0
ARG CMAKE_VERSION=3.16.3

RUN apt-get update && apt-get install -y build-essential curl

COPY build_boost.sh .
RUN ./build_boost.sh ${BOOST_VERSION}
ENV BOOST_ROOT=/boost

COPY install_cmake.sh .
RUN ./install_cmake.sh ${CMAKE_VERSION}

FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=deps /boost /boost
ENV BOOST_ROOT=/boost

COPY --from=deps /opt/cmake/ /opt/cmake/
ENV PATH="/opt/cmake/bin:$PATH"

RUN apt-get update && apt-get install -y git make software-properties-common pkg-config libssl-dev zlib1g-dev bison flex autoconf

COPY install_compilers.sh .
ARG CC=gcc
RUN ./install_compilers.sh gcc

# check if this even does anything
RUN apt-get clean
COPY build_clio.sh .
CMD ["./build_clio.sh"]
# ARG BUILD=0
# RUN if [ $BUILD ]; then git clone https://github.com/xrplf/clio.git && cd clio && cmake -B build && cmake --build build --parallel $(nproc)

# FROM ubuntu:20.04 AS clio

# RUN mkdir output
# WORKDIR output
# COPY --from builder /clio/build/clio_server .
# COPY --from builder /clio/build/clio_tests .
# COPY --from builder /clio/example-config.json .
# RUN strip clio_server
# RUN strip clio_tests
# RUN cp /clio_tests .
# RUN cp /clio_server .
# RUN cp /clio/example-config.json .
