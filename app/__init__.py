# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
import pymysql
import os

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:zx123456@127.0.0.1:3306/online-registration"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = True
app.config["SECRET_KEY"] = "b9da9109cf5347c9b115beada3cf9d3b"
app.config["UP_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)), "static/uploads/")
app.config["UP_BOOK_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)), "static/uploads/books/")
app.config["UP_USER_INFO_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)), "static/uploads/users/")
app.config["UP_NEWS_INFO_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)), "static/uploads/newsinfos/")

app.config.update(dict(
    DEBUG=False,
    MAIL_SERVER='smtp.mxhichina.com',
    MAIL_PORT=465,
    MAIL_USE_SSL=True,
    MAIL_USERNAME='adward@adwardz.top', # 邮箱账号
    MAIL_PASSWORD='******', # 邮箱密码
    # MAIL_DEFAULT_SENDER='From: <adward@adwardz.top>'
))

app.debug = True
db = SQLAlchemy(app)
mail = Mail(app)

from app.registration import registration as regst_blueprint
from app.admin import admin as admin_blueprint

app.register_blueprint(regst_blueprint)
app.register_blueprint(admin_blueprint, url_prefix="/admin")


@app.errorhandler(404)
def page_not_found(error):
    return render_template("registration/404.html"), 404
