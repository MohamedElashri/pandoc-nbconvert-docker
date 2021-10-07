FROM pandoc/ubuntu-latex:latest

# install tex and necessary packages from ubuntu repositories
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install wget
RUN apt-get install xzdec
RUN apt-get install texlive-fonts-recommended -y
RUN apt-get install texlive-plain-generic -y
RUN apt-get install texlive-latex-recommended -y

# install python3 & pip
RUN apt-get update -y && \
    apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    python3-pip && \
    apt-get autoclean && apt-get --purge --yes autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN tlmgr init-usertree
RUN tlmgr update --self 
RUN tlmgr update texlive-scripts
RUN tlmgr install scheme-full 


RUN pip3 install nbconvert

# Set CWD to /source on entry.
# Add -v `pwd`:/source to your run command to make the files in your working
# directory available to pandoc or jupyter
WORKDIR /source

# Expose /source as an external volume
VOLUME /source

ENTRYPOINT ["/usr/local/bin/jupyter"]

CMD ["--help"]
