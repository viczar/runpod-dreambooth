FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-devel as dev-base

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND noninteractive\
    SHELL=/bin/bash
RUN apt-get update --yes && \
    # - apt-get upgrade is run to patch known vulnerabilities in apt-get packages as
    #   the ubuntu base image is rebuilt too seldom sometimes (less than once a month)
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends\
    git\
    wget\
    curl\
    git\
    bash\
    openssh-server &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN pip install jupyterlab
RUN pip install ipywidgets
RUN pip install jupyter-archive
RUN jupyter nbextension enable --py widgetsnbextension

ADD start.sh /

RUN chmod +x /start.sh

CMD [ "/start.sh" ]