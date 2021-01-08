#docker build -t docker-gotty .
FROM ubuntu:latest

WORKDIR /app

ENV PS1 "\n\n> \W \$ "
ENV TERM=linux
ENV PACKAGES bash

#RUN apk --no-cache add $PACKAGES

RUN apt-get update && apt-get -y install wget
ENV GOTTY_BINARY https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_386.tar.gz

RUN wget $GOTTY_BINARY -O gotty.tar.gz && \
    tar -xzf gotty.tar.gz -C /usr/local/bin/ && \
    rm gotty.tar.gz && \
    chmod +x /usr/local/bin/gotty


RUN apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce docker-compose bash

#Bash autocomplete
RUN curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

#RUN service docker start
EXPOSE 8080

COPY files/home/* /root/
COPY app $WORKDIR

RUN git clone https://github.com/eshnil2000/traefik-docker-browser-letsencrypt.git /app/workshop
ENTRYPOINT ["sh", "-c"]
CMD ["service docker start && gotty -w docker run -v /var/run/docker.sock:/var/run/docker.sock -it --rm docker-gotty /bin/bash"]
#CMD ["gotty --permit-write --reconnect bash"]
