FROM python:3.11-slim

WORKDIR /app

COPY main.py .

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD curl -f http://localhost:8080 || exit 1

CMD ["python", "main.py"]

