

FROM rocker/r-ubuntu:latest AS base


WORKDIR /project


COPY . .


RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*


RUN R -e "install.packages('renv', repos = 'https://cloud.r-project.org'); renv::restore()"


ENTRYPOINT ["Rscript", "code/03_render_report.R"]