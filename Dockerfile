FROM continuumio/miniconda3

WORKDIR /app
#WORKDIR /work/ewilson6/workspace/modulytics-5g
#WORKDIR .

# from: https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d25754
#ADD environment.yml /tmp/environment.yml
#RUN conda env create -f /tmp/environment.yml
# Pull the environment name out of the environment.yml
#RUN echo "source activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)" > ~/.bashrc
#ENV PATH /opt/conda/envs/$(head -1 /tmp/environment.yml | cut -d' ' -f2)/bin:$PATH



# copy contents of current host directory into container
COPY . .

# Create the environment:
#COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "modulome_e", "/bin/bash", "-c"]

# Demonstrate the environment is activated:
#RUN echo "Make sure flask is installed:"
#RUN python -c "import flask"

# The code to run when container is started:
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "modulome_e", "python", "-m", "http.server", "8899"]

