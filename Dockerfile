FROM rocker/r-ver:4.1.1

# Install required system dependencies for building R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install renv from CRAN
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

WORKDIR /workspace

# Copy your project files into the container
COPY . .

# Initialize renv and create necessary files
RUN R -e "renv::init(bare = TRUE); renv::snapshot()"

# Restore the environment as defined in the renv.lock file
RUN R -e "renv::restore()"
