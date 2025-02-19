# JBoss WildFly 이미지 사용
FROM jboss/wildfly:latest

# 작업 디렉토리 설정
WORKDIR /opt/jboss/wildfly/standalone/

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
