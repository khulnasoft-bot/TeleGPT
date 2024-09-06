FROM python:3.8-slim-buster

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg git supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy supervisord configuration
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Set up environment
COPY ./requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt && rm -r /tmp/requirements.txt

# Copy the application code
COPY . /code
WORKDIR /code

# Expose necessary ports
EXPOSE 8080 27017

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
