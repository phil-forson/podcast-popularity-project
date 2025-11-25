# ---------- Base image ----------
FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

# ---------- System dependencies ----------
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre-headless \
    wget \
    curl \
    git \
    tini \
    && rm -rf /var/lib/apt/lists/*

# ---------- Spark setup ----------
ENV SPARK_VERSION=3.5.0 \
    HADOOP_VERSION=3 \
    SPARK_HOME=/opt/spark

RUN wget -q https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

ENV PATH="${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}"
ENV PYSPARK_PYTHON=python
ENV PYSPARK_DRIVER_PYTHON=python

# ---------- Python dependencies ----------
# 1) Normal packages from default PyPI
RUN pip install --no-cache-dir \
    jupyterlab \
    pandas \
    numpy \
    matplotlib \
    pyspark==3.5.0 \
    spark-nlp==5.2.2 \
    vaderSentiment \
    transformers

# 2) PyTorch from the CPU wheel index
RUN pip install --no-cache-dir \
    torch --index-url https://download.pytorch.org/whl/cpu

# ---------- Workspace layout ----------
WORKDIR /workspace
RUN mkdir -p /workspace/data /workspace/notebooks

EXPOSE 8888 4040

# ---------- Start JupyterLab ----------
CMD ["tini", "--", "jupyter", "lab", \
     "--notebook-dir=/workspace/notebooks", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root"]
