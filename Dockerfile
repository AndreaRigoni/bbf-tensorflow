# FROM insready/bazel:latest
FROM tensorflow/tensorflow:nightly-devel-py3




# BAZEL UPDATE
RUN apt-get update
RUN apt-get -y install gnupg
RUN apt-get -y install git
RUN apt-get -y install nano
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

# remove previous files in /usr/local
RUN rm -rf /etc/bazel.bazelrc /usr/local/bin/bazel /usr/local/lib/bazel

RUN apt-get update && apt-get -y install bazel
RUN apt-get upgrade -y bazel



RUN cd /; \
	git clone https://github.com/bazelbuild/bazel-buildfarm.git buildfarm; \
	cd buildfarm; \
	bazel build //src/main/java/build/buildfarm:buildfarm-worker; 

RUN cd /buildfarm; \
	bazel build //src/main/java/build/buildfarm:buildfarm-server;

COPY ./bbf_entry.sh /
COPY ./worker.config /
COPY ./server.config /

ENTRYPOINT /bbf_entry.sh

# bad behave ..
RUN ln -s /usr/bin/gcc /usr/sbin/

CMD "print"


