ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}

WORKDIR /usr/src/app
COPY ./* .

RUN apt-get update && apt-get install -y libmilter-dev && rm -rf /var/cache/apt

RUN pip install --no-cache-dir -r requirements.txt && useradd -s /usr/bin/nologin log_milter && chown -R log_milter:log_milter .

USER log_milter

CMD ["python", "log_milter.py", "log_milter_socket" ]
