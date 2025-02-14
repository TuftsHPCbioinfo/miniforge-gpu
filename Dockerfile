FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Author label
LABEL maintainer="Yucheng Zhang <Yucheng.Zhang@tufts.edu>"

# Help message
LABEL description="This container contains miniforge installed on nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04."

# Set environment variables
ENV PATH=/opt/miniforge/bin:$PATH

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends build-essential wget git && \
    wget https://github.com/conda-forge/miniforge/releases/download/24.11.2-1/Miniforge3-24.11.2-1-Linux-x86_64.sh  \
    && bash Miniforge3-24.11.2-1-Linux-x86_64.sh  -b -p /opt/miniforge \
    && rm -f Miniforge3-24.11.2-1-Linux-x86_64.sh  

# Update conda and clean
RUN conda update --all \
    && conda clean --all --yes \
    && rm -rf /root/.cache/pip

# Update some common python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
    
# Set default shell to bash
SHELL ["/bin/bash", "-c"]
