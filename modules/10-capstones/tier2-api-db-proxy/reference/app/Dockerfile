FROM python:3.12-slim
ENV PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1
RUN useradd --create-home --uid 10001 app
WORKDIR /home/app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY --chown=app:app app.py .
USER app
EXPOSE 8000
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://localhost:8000/health').status==200 else 1)"
CMD ["gunicorn", "-b", "0.0.0.0:8000", "-w", "2", "app:app"]
