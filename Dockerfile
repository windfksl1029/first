# 1. Tomcat 9 이미지 사용 (JDK 11 포함, Temurin 배포판)
FROM tomcat:9.0-jdk11-temurin

# 2. Exem 에이전트 설치
# 임시 폴더에 exem.tar를 복사하고, /agent 디렉토리를 만들어 압축 해제 후 원본 파일 삭제
COPY exem.tar /tmp/exem.tar
RUN mkdir /agent && \
    tar -xvf /tmp/exem.tar -C /agent && \
    rm /tmp/exem.tar

# 3. 에이전트 실행을 위한 CATALINA_OPTS 환경 변수 설정
# Tomcat은 CATALINA_OPTS 환경 변수를 Java 실행 옵션으로 사용합니다.
ENV CATALINA_OPTS="-javaagent:/agent/exem/java/lib/exem-java-agent.jar -Dexem.agent.name=phisserver-test"

# 4. (선택) Tomcat 설정 파일 복사
# 만약 Tomcat의 설정을 변경해야 한다면, conf/server.xml 파일을 수정하여 복사합니다.
# COPY server.xml /usr/local/tomcat/conf/server.xml

# 5. 웹 애플리케이션 배포
# 소스 코드를 Tomcat의 웹 앱 배포 폴더(webapps) 아래 ROOT 폴더로 복사합니다.
COPY ROOT/ /usr/local/tomcat/webapps/ROOT/

# 6. HTTP 포트 노출 (Tomcat 기본 포트와 동일)
EXPOSE 8080

# 7. Tomcat 실행
# 기본 Tomcat 이미지는 CMD ["catalina.sh", "run"]이 내장되어 있어 별도로 CMD를 작성할 필요가 없습니다.
