FROM solita/clojure-for-circleci-builds
 
ENV JMETER_VERSION 4.0

WORKDIR /
USER root

# Installing jmeter
RUN   mkdir /jmeter \
        && cd /jmeter/ \
        && wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
        && tar -xzf apache-jmeter-$JMETER_VERSION.tgz \ 
    && rm apache-jmeter-$JMETER_VERSION.tgz 

# Settingt Jmeter Home
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/

# Finally Adding Jmeter to the Path
ENV PATH $JMETER_HOME/bin:$PATH

WORKDIR /jmeter/apache-jmeter-$JMETER_VERSION/lib/ext/

RUN wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip
RUN unzip -j JMeterPlugins-Standard-1.4.0.zip lib/ext/JMeterPlugins-Standard.jar

RUN wget https://jmeter-plugins.org/downloads/file/ServerAgent-2.2.1.zip
RUN unzip -j ServerAgent-2.2.1.zip ServerAgent.jar

RUN wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-Extras-1.4.0.zip
RUN unzip -j JMeterPlugins-Extras-1.4.0.zip lib/ext/JMeterPlugins-Extras.jar

RUN wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-1.4.0.zip
RUN unzip -j JMeterPlugins-ExtrasLibs-1.4.0.zip lib/ext/JMeterPlugins-ExtrasLibs.jar

RUN wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-WebDriver-1.4.0.zip
RUN unzip -j JMeterPlugins-WebDriver-1.4.0.zip lib/ext/JMeterPlugins-WebDriver.jar

RUN wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-Hadoop-1.4.0.zip
RUN unzip -j JMeterPlugins-Hadoop-1.4.0.zip lib/ext/JMeterPlugins-Hadoop.jar

RUN rm *.zip

WORKDIR /tmp
USER circleci
