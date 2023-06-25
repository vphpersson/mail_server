ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}

WORKDIR /usr/src/app
COPY ./* .

RUN apt-get update && apt-get install -y libmilter-dev && rm -rf /var/cache/apt

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "log_milter.py", "log_milter_socket"]
