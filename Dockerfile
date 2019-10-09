FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"] 

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:beineri/opt-qt-5.12.2-bionic
RUN apt-get update  
RUN apt-get install -y --fix-missing \
    qt512-meta-minimal \
    qt512charts-no-lgpl \
    libfontconfig1 \
    git \
    libboost-dev \
    unzip \
    mesa-common-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    mesa-utils \
    wget \
    g++ \
    make \
    build-essential \
    zlib1g \
    zlib1g-dev 

RUN echo "source /opt/qt512/bin/qt512-env.sh" >> ~/.bashrc 

RUN mkdir dsistudio
WORKDIR dsistudio
RUN git clone -b master https://github.com/frankyeh/DSI-Studio.git src
RUN wget https://github.com/frankyeh/TIPL/zipball/master
RUN unzip master
RUN mv frankyeh-TIPL-* src/tipl

RUN mkdir build
WORKDIR build
RUN source /opt/qt512/bin/qt512-env.sh && qmake ../src && make

WORKDIR ..
RUN wget https://www.dropbox.com/s/rq5khgmoyiye0op/dsi_studio_other_files.zip?dl=1 -O dsi_studio_other_files.zip
RUN unzip dsi_studio_other_files.zip -d dsi_studio_64
WORKDIR dsi_studio_64
RUN cp ../build/dsi_studio .

CMD ./dsi_studio

FROM ubuntu:18.04
COPY --from=0 /dsistudio/dsi_studio_64 /opt/dsistudio
RUN apt-get update -qq
RUN apt-get install -qq --no-install-recommends -y software-properties-common
RUN add-apt-repository -y ppa:beineri/opt-qt-5.12.2-bionic
RUN apt-get update -qq
RUN apt-get install -qq --fix-missing --no-install-recommends -y \
  qt512-meta-minimal \
  qt512charts-no-lgpl\
  zlib1g \
  libqt5opengl5 \
  libglu1-mesa \
  freeglut3
SHELL ["/bin/bash", "-c"] 
RUN echo "source /opt/qt512/bin/qt512-env.sh" >> ~/.bashrc 
CMD ["/opt/dsistudio/dsi_studio"]
