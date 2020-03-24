# alpine oracle jdk8
# alpine 3.11.3
# oracle java 1.8.0_121
# version 1.0
FROM alpine:3.11.3
RUN mkdir -p /opt/java
COPY jdk-8u121-linux-x64.tar.gz /opt/java/jdk-8u121-linux-x64.tar.gz
COPY glibc-2.30-r0.apk /root/glibc-2.30-r0.apk
RUN cd /opt/java && tar -zxvf jdk-8u121-linux-x64.tar.gz
RUN ln -s /opt/java/jdk1.8.0_121 /opt/java/current

RUN echo "https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.11/main/" > /etc/apk/repositories && apk update 

#******************Alpine安装 Glibc *****************
RUN apk --no-cache add ca-certificates wget
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN apk add /root/glibc-2.30-r0.apk

#*****************设置Java环境****************
ENV JAVA_HOME=/opt/java/current
ENV CLASSPATH=$JAVA_HOME/bin
ENV PATH=.:$JAVA_HOME/bin:$PATH

# CMD ["java","-version"]
