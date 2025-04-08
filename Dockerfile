# Use Python base image
FROM python:3.10-slim

# Creating custom Jmeter Image
FROM justb4/jmeter:latest

# Create necessary directories
RUN mkdir -p /opt/apache-jmeter-5.6.2/lib/ext

# Download Plugins Manager JAR
RUN wget -O /opt/apache-jmeter-5.6.2/lib/ext/jmeter-plugins-manager.jar https://jmeter-plugins.org/get/

# Install Plugins via Plugins Manager
RUN java -cp /opt/apache-jmeter-5.6.2/lib/ext/jmeter-plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller
RUN java -jar /opt/apache-jmeter-5.6.2/lib/ext/jmeter-plugins-manager.jar install jpgc-standard

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
