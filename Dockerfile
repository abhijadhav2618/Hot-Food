# Step 1: Use official Python image
FROM python:3.10-slim

# Step 2: Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Step 3: Set working directory
WORKDIR /app

# Step 4: Install system dependencies (for psycopg2, mysqlclient, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Step 5: Copy requirements.txt
COPY requirements.txt /app/

# Step 6: Debugging Step (Verify File Exists)
RUN ls -l /app/ && cat /app/requirements.txt

# Step 7: Upgrade pip and Install Dependencies
RUN pip install --upgrade pip setuptools wheel && pip install --no-cache-dir -r requirements.txt

# Step 8: Copy Django Project Files
COPY . /app/

# Step 9: Expose Port
EXPOSE 8000

# Step 10: Run the Application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "src.wsgi:application"]
