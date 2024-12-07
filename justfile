set shell := [ "nu", "-c" ]

export JAVA_HOME := "/home/oli/Tools/graalvm-jdk-22.0.2+9.1"

JAVA := JAVA_HOME / "bin" / "java"

default:
    just --list
clean:
    ./mvnw --offline clean
compile:
    ./mvnw --offline compile
build:
    ./mvnw --offline verify
run:
    {{ JAVA }} -jar target/benchmarks.jar
watch:
    watch . --glob **/*.java { clear; ./mvnw compile --fail-fast --quiet --offline --threads 16 }
slides:
    mkdir target/docs
    pandoc -t revealjs --incremental --embed-resources --standalone docs/presentation.md -o target/docs/presentation.html
present: slides
    start target/docs/presentation.html
versions_up:
    ./mvnw versions:update-properties
    ./mvnw versions:use-latest-releases
    ./mvnw versions:commit
    ./mvnw versions:display-plugin-updates
 
