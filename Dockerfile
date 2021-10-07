FROM jgoldfar/pandoc-docker-bibtex:latest

RUN set -x \
    && tlmgr init-usertree \ 
    # Select closest mirror automatically: http://tug.org/texlive/doc/install-tl.html

    && tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet/ \ 
    # Using latest TeX Live repository

    && tlmgr update --self --verify-repo=none \ 
    #update tlgmr 

    && tlmgr update texlive-scripts \ 
    # Solves "Cannot install ctex via tlmgr: "Unknown option: status-file" bug

    && (tlmgr install --verify-repo=none scheme-full || true) \ 
    # runs && tlmgr install scheme-ful  instllation

# install python3 & pip
RUN apt-get update -y && \
    apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    python3-pip && \
    apt-get autoclean && apt-get --purge --yes autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install nbconvert

# Set CWD to /source on entry.
# Add -v `pwd`:/source to your run command to make the files in your working
# directory available to pandoc or jupyter
WORKDIR /source

# Expose /source as an external volume
VOLUME /source

ENTRYPOINT ["/usr/local/bin/jupyter"]

CMD ["--help"]
