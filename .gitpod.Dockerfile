FROM gitpod/workspace-full

# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/
RUN sudo apt-get update
RUN sudo apt-get install openjdk-8-jre -y
RUN echo "deb https://downloads.apache.org/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
RUN curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
RUN sudo apt-get update
RUN sudo apt-get install cassandra -y
RUN sudo service cassandra start
RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN cassandra

# Create folders
RUN (for dir in /var/lib/cassandra \
                /var/lib/spark \
                /var/lib/dsefs \
                /var/lib/datastax-agent \
                /var/log/cassandra \
                /var/log/spark \
                /config ; do \
        mkdir -p $dir && chown -R dse:dse $dir && chmod 777 $dir ; \
    done )