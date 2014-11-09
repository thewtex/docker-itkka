FROM ubuntu:14.04
MAINTAINER Matt McCormick <matt.mccormick@kitware.com>

RUN apt-get update
RUN apt-get install -y wget
RUN wget -O- http://neuro.debian.net/lists/trusty.au.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
RUN apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 2649A5A9
RUN apt-get update

RUN apt-get install -y cmake cmake-curses-gui
RUN apt-get install -y libinsighttoolkit4-dev
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y build-essential
RUN apt-get install -y libjpeg-dev libtiff5-dev libpng12-dev
RUN apt-get install -y libopenblas-dev liblapack-dev

RUN mkdir -p /opt/src
WORKDIR /opt/src
COPY sundials-2.5.0.tar.gz /opt/src/sundials-2.5.0.tar.gz
RUN tar xvzf sundials-2.5.0.tar.gz
WORKDIR /opt/bin
RUN mkdir sundials-2.5.0
WORKDIR /opt/bin/sundials-2.5.0
RUN cmake -DBUILD_STATIC_LIBS=FALSE \
  -DBUILD_SHARED_LIBS=TRUE \
  -DCMAKE_BUILD_TYPE=Release \
  /opt/src/sundials-2.5.0
RUN make -j3
RUN make install
RUN ldconfig

WORKDIR /opt/src
COPY SourceCode3_itkka-src-140930.tgz /opt/src/SourceCode3_itkka-src-140930.tgz
RUN tar xvzf SourceCode3_itkka-src-140930.tgz
WORKDIR /opt/bin
RUN mkdir -p itkka
WORKDIR /opt/bin/itkka
RUN cmake -DCMAKE_BUILD_TYPE:STRING=Release /opt/src/itkka
RUN make -j3

CMD ["/bin/bash"]
