FROM swipl/swipl
RUN apt-get install -y python python-dev python-pip
COPY ../application.pl *.py requirements ./
RUN pip install -r requirements
CMD ["python", "web_socket_server.py"]
