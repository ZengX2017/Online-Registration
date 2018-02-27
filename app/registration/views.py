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