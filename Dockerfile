# Use the latest Debian image as the base
FROM debian:latest

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg git python3 python3-pip python3-venv default-jre default-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create and activate a virtual environment
RUN python3 -m venv /opt/venv

# Set the environment variables for the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade to latest pip within the virtual environment
RUN pip install --upgrade pip

# Copy your repository into the Docker image
COPY . /mxeval

# Set the working directory
WORKDIR /mxeval

# Install your package within the virtual environment
RUN pip install -e /mxeval

# Set the entrypoint
ENTRYPOINT ["evaluate_functional_correctness"]

# Default command (can be overridden by command line arguments)
CMD ["data/mbxp/examples/mbjp_samples.jsonl", "--problem_file", "data/mbxp/mbjp_release_v1.2.jsonl"]
