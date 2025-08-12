FROM python:3.11-slim

# Working directory
WORKDIR /app

# Install dependencies without caching to reduce image size
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Run app
CMD ["python", "main.py"]

# Expose port
EXPOSE 5000
