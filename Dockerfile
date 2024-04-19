# build stage
FROM gradle:7.6.1 AS builder
WORKDIR /usr/app/
COPY . .
RUN gradle build -x test

# package build
FROM openjdk:17
ENV JAR_NAME=bookshop-0.0.1-SNAPSHOT.jar
ENV APP_HOME=/usr/app/
ENV BOOK_IMAGES_PATH=$APP_HOME/bookImages/
WORKDIR $APP_HOME
COPY --from=builder $APP_HOME .
EXPOSE 8080
ENTRYPOINT exec java -jar $APP_HOME/build/libs/$JAR_NAME