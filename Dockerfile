# JBoss WildFly 이미지 사용
FROM jboss/wildfly:latest

# 작업 디렉토리 설정
WORKDIR /opt/jboss/wildfly/standalone/


RUN mkdir /opt/jboss/wildfly/standalone/agent
COPY exem.tar /opt/jboss/wildfly/standalone/agent
RUN tar -xvf /tmp/exem.tar -C /opt/jboss/wildfly/standalone/agent

# 2. 에이전트 실행을 위한 JAVA_OPTS 환경 변수 설정
# JBoss WildFly 이미지는 JAVA_OPTS 환경 변수에 있는 값을 자동으로 Java 실행 옵션으로 사용합니다.
ENV JAVA_OPTS="-javaagent:/agent/exem/java/lib/exem-java-agent.jar -Dexem.agent.name=phisserver-test"

# 수정된 standalone.xml 복사
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml
# 수정된 standalone.conf 복사
#COPY standalone.conf /opt/jboss/wildfly/bin/standalone.conf

# 수정된 standalone.xml 복사
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

# Exploded WAR 디렉토리 생성
RUN mkdir -p /opt/jboss/wildfly/standalone/deployments/ROOT.war

# 소스 코드 복사
COPY ROOT/ /opt/jboss/wildfly/standalone/deployments/ROOT.war/

# JBoss 실행
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]

# HTTP 포트 노출
EXPOSE 8080
