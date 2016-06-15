# docker-ib-gateway

Docker container that launches the Interactive Brokers Gateway GUI inside of an X virtual frame buffer.

## Before We Start

1. Download the latest client from 

    	http://interactivebrokers.github.io/

2. Unpack and upload "/jars" directory to your local webserver

3. Modify these lines in your "Dockerfile" to point to the correct local webserver

    	RUN  wget -O jts4launch.jar -q http://127.0.0.1/jars/jts4launch.jar \
    	&& wget -O log4j-1.2.17.jar -q http://127.0.0.1/jars/log4j-1.2.17.jar \
    	&& wget -O total.jar -q http://127.0.0.1/jars/total.jar \
    	&& wget -O twslaunch-install4j-1.5.jar -q https://127.0.0.1/jars/twslaunch-install4j-1.5.jar \
    	&& wget -O twslaunch.jar -q http://127.0.0.1/jars/twslaunch.jar

## Usage
	
    docker build ib-gateway .
    docker run -e VNC_PASSWORD=mypass -p 5900:5900 -p 4001:4001 -d ib-gateway

At this point, you should be able to connect with VNC and log in to the gateway. Once logged in, port 4001 will be open for you to make API calls against.

## Contributing

Send a pull request!
