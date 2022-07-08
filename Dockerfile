FROM python:3.9

# required for mariadb connector python installation
RUN apt-get install libmariadb-dev
RUN apt-get install git

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt .

# install python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# the mariadb-connector-python tag was choosen to match the libamariadb-dev version on this python image 
RUN git clone -b 1.0 --single-branch https://github.com/mariadb-corporation/mariadb-connector-python.git
RUN pip3 install ./mariadb-*

# gunicorn
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "run:app"]
