# Using the UBI9 Python 3.9 base image from Red Hat
FROM registry.redhat.io/ubi9/python-39:latest

# Set the working directory
WORKDIR /opt/app-root/src

# Copy pre-downloaded dependencies to the container
COPY ./offline-packages /opt/app-root/src/offline-packages

# Copy the requirements file to the container
COPY requirements.txt /opt/app-root/src/requirements.txt

# Install dependencies from the local offline directory
RUN pip install --no-index --find-links=/opt/app-root/src/offline-packages -r requirements.txt

# Copy application code to the container
COPY . /opt/app-root/src

# Expose the application port (as in the original source)
EXPOSE 8080

# Define the original command to run the application (as in the original source)
# Uncomment the preferred command:
# CMD ["gunicorn", "app:app", "-b", "0.0.0.0:8080", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
CMD ["python", "./app.py"]
