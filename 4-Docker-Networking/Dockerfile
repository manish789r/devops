# Base image: slim Python 3.9
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Install networking diagnostic utilities for connectivity testing
RUN apt-get update && apt-get install -y --no-install-recommends iputils-ping curl && rm -rf /var/lib/apt/lists/*

# Copy dependency list and application code
COPY requirements.txt .
COPY app.py .

# Install all Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the application port
EXPOSE 6001

# Launch the Flask application
CMD ["python", "app.py"]
