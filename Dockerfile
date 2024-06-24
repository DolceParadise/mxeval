# Use a newer Python as generated code can use new features
FROM python:3.10-slim

# Install git
RUN apt-get update && apt-get install -y git

# Upgrade to latest pip
RUN pip install --upgrade pip

# Copy your repository into the Docker image
COPY . /mxeval 

# Install your package
RUN pip install -e /mxeval

# Set the working directory
WORKDIR /mxeval 

# Set the entrypoint
ENTRYPOINT ["evaluate_functional_correctness"]

# Default command (can be overridden by command line arguments)
CMD ["data/mbxp/examples/mbjp_samples.jsonl", "--problem_file", "data/mbxp/mbjp_release_v1.2.jsonl"]
