FROM python:3.4-alpine
ADD . /code
WORKDIR /code
COPY app.py /code
RUN pip install -r requirements.txt
CMD ["python", "app.py"]