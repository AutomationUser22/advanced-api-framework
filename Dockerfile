# Use Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY requirements.txt .
COPY tests/ ./tests/
COPY data/ ./data/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install requests pytest pytest-html

# Command to run tests
CMD ["pytest", "--html=report.html"]
