FROM jenkins:latest

ENV JAVA_OPTS="-Xmx4096m -Djenkins.install.runSetupWizard=false"

USER root
ARG MINIFI_VERSION=0.5.0
ENV MINIFI_BASE_DIR /opt/
ENV MINIFI_HOME $MINIFI_BASE_DIR/jenkins-cliente
ENV MINIFI_BINARY_URL https://archive.apache.org/dist/nifi/minifi/$MINIFI_VERSION/minifi-$MINIFI_VERSION-bin.tar.gz 

# Download, validate, and expand Apache MiNiFi binary.
RUN wget $MINIFI_BINARY_URL -O $MINIFI_BASE_DIR/minifi-$MINIFI_VERSION-bin.tar.gz \ 
		&& tar -xvzf $MINIFI_BASE_DIR/minifi-$MINIFI_VERSION-bin.tar.gz -C $MINIFI_BASE_DIR \ 
		&& rm $MINIFI_BASE_DIR/minifi-$MINIFI_VERSION-bin.tar.gz \ 
		&& mv $MINIFI_BASE_DIR/minifi-$MINIFI_VERSION $MINIFI_HOME


#Setting up Jenkins
USER root

#Copying and executing Launcher
COPY config_files/launcher.sh /usr/local/bin/launcher.sh
RUN /usr/local/bin/launcher.sh


