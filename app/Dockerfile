FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
  build-essential \
  wget \
  ca-certificates \
  pkg-config \
  && rm -rf /var/lib/apt/lists/*

RUN wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"

ENV CONDA_DIR=/opt/conda
RUN bash Miniforge3.sh -b -p ${CONDA_DIR}

ENV PATH=${CONDA_DIR}/bin:${PATH}
RUN . ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate base
RUN echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate base" >> /etc/skel/.bashrc
RUN echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate base" >> ~/.bashrc

RUN conda update -y conda
RUN pip install --upgrade pip

RUN conda install -y -c conda-forge conda-libmamba-solver \
  && conda config --set solver libmamba

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY . .

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000