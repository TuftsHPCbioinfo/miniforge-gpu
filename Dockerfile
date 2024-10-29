FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Author label
LABEL maintainer="Yucheng Zhang <Yucheng.Zhang@tufts.edu>"

# Help message
LABEL description="This container contains miniforge installed on nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04."

# Set environment variables
ENV PATH=/opt/miniforge/bin:$PATH

# Download and install Anaconda
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends build-essential wget git && \
    wget -q -c https://github.com/conda-forge/miniforge/releases/download/24.9.0-0/Miniforge3-24.9.0-0-Linux-x86_64.sh && \
    bash Miniforge3-24.9.0-0-Linux-x86_64.sh -b -p /opt/miniforge && \
    rm -f Miniforge3-24.9.0-0-Linux-x86_64.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Update conda
RUN conda update --all

# Clean up unnecessary files
RUN conda clean --all --yes && \
    rm -rf /root/.cache/pip
    
# Set default shell to bash
SHELL ["/bin/bash", "-c"]