# Official Python slim runtime
FROM python:3.9-slim

# Set the application working directory
WORKDIR /app

# Install Python dependencies before copying app code for better layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY app.py .

# Expose the Flask port
EXPOSE 5000

# Start the Flask application
CMD ["python", "app.py"]
