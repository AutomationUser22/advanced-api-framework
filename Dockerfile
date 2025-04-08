# Use Python base image
FROM python:3.10-slim

# Creating custom Jmeter Image
FROM justb4/jmeter:latest
# Install Plugins Manager
RUN wget -O /opt/jmeter/lib/ext/jmeter-plugins-manager-1.10.jar \
    https://jmeter-plugins.org/get/

# Install ViewResultsTree (via Plugins Manager)
RUN java -jar /opt/jmeter/lib/ext/jmeter-plugins-manager-1.10.jar \
    install jpgc-standard

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
