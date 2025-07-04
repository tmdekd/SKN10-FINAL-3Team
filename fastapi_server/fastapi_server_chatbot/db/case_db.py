import pymysql
import os

def get_case_db():
    mysql_host = os.getenv("MYSQL_HOST")
    mysql_port = os.getenv("MYSQL_PORT")
    mysql_user = os.getenv("MYSQL_USER")
    mysql_pwd = os.getenv("MYSQL_PWD")
    mysql_db = os.getenv("MYSQL_DB")

    return pymysql.connect(
        host=mysql_host,
        port=int(mysql_port),
        user=mysql_user,
        password=mysql_pwd,
        database=mysql_db,
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )