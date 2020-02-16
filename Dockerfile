FROM alpine:3.9                                                                                                         
                                                                                                                        
WORKDIR /app                                                                                                            
ADD . /app/src

RUN apk add --no-cache python3 python3-dev openssl-dev build-base libffi-dev && \
    pip3 install cython numpy && \
    cd /app/src && python3 setup.py install && \
    cp -r /app/src/examples /usr/lib/python3.6/site-packages/bitshares_pricefeed-0.0.10-py3.6.egg/bitshares_pricefeed/ && \
    cd && rm -rf /app/src && \ 
    apk del python3-dev openssl-dev build-base libffi-dev && \
    apk add --no-cache libstdc++

VOLUME ["/conf", "/root/.local/share/bitshares"] 

CMD [ "/usr/local/bin/bitshares-pricefeed", "--configfile", "/config/config.yaml", "update" ]
