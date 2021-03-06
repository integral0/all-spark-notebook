#!/usr/bin/env bash
##
# Generated by Cloudera Manager and should not be modified directly
##

SELF="$(cd $(dirname $BASH_SOURCE) && pwd)"
if [ -z "$SPARK_CONF_DIR" ]; then
  export SPARK_CONF_DIR="$SELF"
fi

export SPARK_HOME=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/spark

SPARK_PYTHON_PATH=""
if [ -n "$SPARK_PYTHON_PATH" ]; then
  export PYTHONPATH="$PYTHONPATH:$SPARK_PYTHON_PATH"
fi

export HADOOP_HOME=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop
export HADOOP_COMMON_HOME="$HADOOP_HOME"

if [ -n "$HADOOP_HOME" ]; then
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HADOOP_HOME}/lib/native
fi

SPARK_EXTRA_LIB_PATH=""
if [ -n "$SPARK_EXTRA_LIB_PATH" ]; then
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SPARK_EXTRA_LIB_PATH
fi

export LD_LIBRARY_PATH

HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-$SPARK_CONF_DIR/yarn-conf}
HIVE_CONF_DIR=${HIVE_CONF_DIR:-/etc/hive/conf}
if [ -d "$HIVE_CONF_DIR" ]; then
  HADOOP_CONF_DIR="$HADOOP_CONF_DIR:$HIVE_CONF_DIR"
fi
export HADOOP_CONF_DIR

PYLIB="$SPARK_HOME/python/lib"
if [ -f "$PYLIB/pyspark.zip" ]; then
  PYSPARK_ARCHIVES_PATH=
  for lib in "$PYLIB"/*.zip; do
    if [ -n "$PYSPARK_ARCHIVES_PATH" ]; then
      PYSPARK_ARCHIVES_PATH="$PYSPARK_ARCHIVES_PATH,local:$lib"
    else
      PYSPARK_ARCHIVES_PATH="local:$lib"
    fi
  done
  export PYSPARK_ARCHIVES_PATH
fi

if [ -f "$SELF/classpath.txt" ]; then
  export SPARK_DIST_CLASSPATH=$(paste -sd: "$SELF/classpath.txt")
fi

# Force single-threaded BLAS (CDH-58082).
export MKL_NUM_THREADS=${MKL_NUM_THREADS:-1}
export OPENBLAS_NUM_THREADS=${OPENBLAS_NUM_THREADS:-1}

# Spark uses `set -a` to export all variables created or modified in this
# script as env vars. We use a temporary variables to avoid env var name
# collisions.
# If PYSPARK_PYTHON is unset, set to CDH_PYTHON
TMP_PYSPARK_PYTHON=${PYSPARK_PYTHON:-''}
# If PYSPARK_DRIVER_PYTHON is unset, set to CDH_PYTHON
TMP_PYSPARK_DRIVER_PYTHON=${PYSPARK_DRIVER_PYTHON:-}

if [ -n "$TMP_PYSPARK_PYTHON" ] && [ -n "$TMP_PYSPARK_DRIVER_PYTHON" ]; then
  export PYSPARK_PYTHON="$TMP_PYSPARK_PYTHON"
  export PYSPARK_DRIVER_PYTHON="$TMP_PYSPARK_DRIVER_PYTHON"
fi
