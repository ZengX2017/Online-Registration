# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import render_template, redirect, url_for, flash, session, request, abort
from app.registration.forms import RegisterForm, LoginForm
from app.models import User
from app import db
from werkzeug.security import generate_password_hash
from . import registration


# 首页
@registration.route("/")
def index():
    return render_template("registration/index.html")


# 用户登录
@registration.route("/login/", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(name=data["name"]).first()
        if not user.check_pwd(data["pwd"]):
            flash("密码错误！", "err")
            return redirect(url_for("registration.login"))
        session["user"] = user.name
        session["user_id"] = user.id
        # userlog = Userlog(
        #     user_id=user.id,
        #     ip=request.remote_addr,
        # )
        # db.session.add(userlog)
        # db.session.commit()
        return redirect(url_for("registration.userinfo"))
    return render_template("registration/login.html", form=form)


# 用户注销
@registration.route("/logout/")
def logout():
    session.pop("user", None)
    session.pop("user_id", None)
    return redirect(url_for('registration.login'))


# 用户注册
@registration.route("/register/", methods=["GET", "POST"])
def register():
    form = RegisterForm()
    if form.validate_on_submit():
        data = form.data
        user = User(
            name=data["name"],
            email=data["email"],
            pwd=generate_password_hash(data["pwd"]),
            gender=0,
            id_status=0
        )
        db.session.add(user)
        db.session.commit()
        flash("注册成功！", "OK")
        return redirect(url_for("registration.login"))
    return render_template("registration/register.html", form=form)


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