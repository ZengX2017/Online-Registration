# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import render_template, redirect, url_for, flash, session, request, abort
from . import registration


# 首页
@registration.route("/")
def index():
    return render_template("registration/index.html")


# 用户登录
@registration.route("/login/", methods=["GET", "POST"])
def login():
    return render_template("registration/login.html")


# 用户注册
@registration.route("/register/", methods=["GET", "POST"])
def register():
    return render_template("registration/register.html")


# 个人中心
@registration.route("/userinfo/", methods=["GET", "POST"])
def userinfo():
    return render_template("registration/userinfo.html")


# 资讯
@registration.route("/newscategory/", methods=["GET", "POST"])
def newscategory():
    return render_template("registration/newscategory.html")


# 图书
@registration.route("/book/", methods=["GET", "POST"])
def book():
    return render_template("registration/book.html")