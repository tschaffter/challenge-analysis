FROM tschaffter/rstudio:4.0.5-6d365007

# Create conda environments
COPY conda /tmp/conda
ARG conda_env="challenge-analysis"
RUN conda init bash \
    && conda env create -f /tmp/conda/${conda_env}/environment.yml \
    && rm -fr /tmp/conda \
    # Fix libssl issue that affects conda env used with reticulate
    && cp /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
        /opt/miniconda/envs/${conda_env}/lib/libssl.so.1.1 \
    && echo "conda activate ${conda_env}" >> ~/.bashrc