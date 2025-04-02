# Step 1: Use official Python image
FROM python:3.10-slim

# Step 2: Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Step 3: Set working directory
WORKDIR /app

# Step 4: Install system dependencies (if needed)
RUN apt-get update && apt-get install -y libpq-dev gcc python3-dev && rm -rf /var/lib/apt/lists/*

# Step 5: Copy requirements.txt and install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip setuptools wheel && pip install --no-cache-dir -r requirements.txt

# Step 6: Copy Django project files
COPY . /app/

# Step 7: Expose port
EXPOSE 8000

# Step 8: Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "src.wsgi:application"]
