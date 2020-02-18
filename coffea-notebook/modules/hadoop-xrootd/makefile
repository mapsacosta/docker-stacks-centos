MAVEN_PROFILE=standalone

all: clean package test

clean:
	/opt/apache-maven-3.6.0/bin/mvn clean
	rm -f *.jar

package:
	/opt/apache-maven-3.6.0/bin/mvn package -DskipTests $(MAVEN_FLAGS)

test:
	set -e ;\
    export HADOOP_CLASSPATH="${PWD}/*:$(hadoop classpath)";\
	for file in src/tests/* ; do $${file} && echo '** Success **' || exit ; done ;
