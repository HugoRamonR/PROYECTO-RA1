FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# Versions
ENV SPARK_VERSION=4.0.1
ENV HADOOP_VERSION=3

# Paths
ENV SPARK_HOME=/usr/local/spark
ENV PATH="${SPARK_HOME}/bin:${PATH}"
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    curl \
    ca-certificates \
    bash \
    procps \
    tini \
  && rm -rf /var/lib/apt/lists/*

# Install Spark
RUN set -eux; \
    curl -fsSL "https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" -o /tmp/spark.tgz; \
    tar -xzf /tmp/spark.tgz -C /usr/local; \
    mv "/usr/local/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" "${SPARK_HOME}"; \
    rm /tmp/spark.tgz; \
    test -f "${SPARK_HOME}/bin/spark-submit"

# Python deps
RUN pip install --no-cache-dir \
    pyspark==4.0.1 \
    jupyterlab \
    pandas \
    pyarrow

WORKDIR /app
RUN mkdir -p /app/data /app/notebooks /app/warehouse

COPY . .

EXPOSE 8888

ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--allow-root","--NotebookApp.token=''"]
