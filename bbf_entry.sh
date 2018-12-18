#!/bin/sh

print() {
 echo "play with server or worker"
}

server() {
  echo "Start SERVER"
  /buildfarm/bazel-bin/src/main/java/build/buildfarm/buildfarm-server \
  --jvm_flag=-Djava.util.logging.config.file=/buildfarm/examples/debug.logging.properties \
  /server.config
}

worker() {
  echo "Start WORKER"
  /buildfarm/bazel-bin/src/main/java/build/buildfarm/buildfarm-worker \
  --jvm_flag=-Djava.util.logging.config.file=/buildfarm/examples/debug.logging.properties \
  /worker.config
}

worker_release() {
  echo "Start WORKER no DEBUG info"
  /buildfarm/bazel-bin/src/main/java/build/buildfarm/buildfarm-worker \
  /worker.config
}

# compile() {
#   echo "Compiling Tensorflow"
#   cd /tensorflow
#   ./configure <<< y 
#   bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package --spawn_strategy=remote --genrule_strategy=remote --strategy=Javac=remote --strategy=Closure=remote --remote_executor=server:8980 --verbose_failures
# }

$@
