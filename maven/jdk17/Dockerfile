FROM maven:3.8.5-openjdk-17
ENV MAVEN_VERSION 3.8.5
# 修改欢迎命令
COPY .bashrc /root/.bashrc
# 修改docker时间为东八区
RUN echo "Asia/Shanghai" > /etc/timezone
