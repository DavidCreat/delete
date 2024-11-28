FROM python:3.9

RUN apt-get update && apt-get install -y libmariadb-dev-compat libmariadb-dev

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8001

CMD ["gunicorn", "--bind", "0.0.0.0:8001", "backend.wsgi:application"]
