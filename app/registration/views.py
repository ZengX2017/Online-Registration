# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import render_template, redirect, url_for, flash, session, request, abort
from app.registration.forms import RegisterForm, LoginForm, UserInfoForm, ChangePwdForm
from app.models import User, Userlog, NewsInfo, NewsTag, NewsCategory
from app import db
from werkzeug.security import generate_password_hash
from . import registration


# 首页
@registration.route("/")
def index():
    newsinfos = NewsInfo.query.order_by(NewsInfo.addtime.asc())
    newstag = NewsTag.query.filter_by(name="公告栏").first_or_404()  # 找出公告栏所在newstag表中的数据
    newstags = newsinfos.join(NewsTag).filter(
        NewsTag.id == newstag.id
    )  # 找出newsinfo表中隶属公告栏的数据
    # newscategorys = newstags.join(NewsCategory).filter(
    #     NewsCategory.id == newstag.newscategory_id
    # )
    if newstags.count() <= 5:
        newstags = newstags[:]  # 不超过6条数据则全部显示
    else:
        newstags = newstags[newstags.count() - 5:]  # 超过6条数据后选最后5条数据出现
    newstags.reverse()  # 数据翻转，目的是为了将最新的数据显示在第一条
    return render_template("registration/index.html", newstags=newstags)


'''
理解本方法（newscategory）：
    在nav.html页中用get方式取得标签，然后在本方法中润色，通过传递过来的标签（具有唯一性）进行数据查找
    找到name所对应的newstag，然后再根据newstag去取得所属类别，通过Jinja2模板渲染在前台。
    此处加newstag_name的作用有3，一是面包屑导航栏的显示，二是根据判断newstags的tag是否为当前name，是的话加上active
    三是左侧小导航的显示和中间面板主体左上角的显示    
'''


# 资讯标签和类别相关
@registration.route("/newscategory/<name>", methods=["GET"])
def newscategory(name):
    newstag = NewsTag.query.filter_by(name=name).first_or_404()  # 通过nav请求找到tag
    newstag_name = name  # 存一下当前请求的name
    newscategory = newstag.newscategory.name  # 根据当前tag找到所属类别，为了面包屑导航栏的一级显示
    newscategorys = NewsCategory.query.filter_by(name=newscategory).first_or_404()  # 找出当前所属类别的id
    newstags = NewsTag.query.filter_by(newscategory_id=newscategorys.id)  # 根据所属类别的id找出此类别下所有的标签
    newsinfos = NewsInfo.query.filter_by(newstag_id=newstag.id).order_by(
        NewsInfo.addtime.asc()
    )  # 根据当前标签找出此标签下的所有内容
    newsinfos = newsinfos[:]  # 将数据集转为列表，目的是为了翻转
    newsinfos.reverse()
    return render_template("registration/newscategory.html", newstag=newstag, newstag_name=newstag_name,
                           newscategory=newscategory, newstags=newstags, newsinfos=newsinfos)


# 资讯详情
@registration.route("/detail/<int:id>/", methods=["GET"])
def detail(id=None):
    newsinfo = NewsInfo.query.get_or_404(id)
    newstag = newsinfo.newstag.name
    newscategory = newsinfo.newstag.newscategory.name
    newsinfo.view_num = newsinfo.view_num + 1
    db.session.add(newsinfo)
    db.session.commit()
    return render_template("registration/detail.html", newsinfo=newsinfo, newstag=newstag, newscategory=newscategory)


# 用户登录
@registration.route("/login/", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(email=data["email"]).first()
        if not user.check_pwd(data["pwd"]):
            flash("密码错误！", "err")
            return redirect(url_for("registration.login"))
        session["user"] = user.name
        session["user_id"] = user.id
        userlog = Userlog(
            user_id=user.id,
            ip=request.remote_addr,
        )
        db.session.add(userlog)
        db.session.commit()
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
# 头像没实现
@registration.route("/userinfo/", methods=["GET", "POST"])
def userinfo():
    form = UserInfoForm()
    user = User.query.filter_by(id=session['user_id']).first_or_404()
    if request.method == "GET":
        form.gender.data = user.gender
        form.id_card.data = user.id_card
        form.phone.data = user.phone
        form.area.data = user.area
    if form.validate_on_submit():
        data = form.data
        ui = User.query.filter_by(id_card=data["id_card"]).count()
        up = User.query.filter_by(phone=data["phone"]).count()
        if user.id_card != data["id_card"] and ui == 1:
            flash("此身份证已经存在！请输入正确的身份证号码！", "err")
            return redirect(url_for("registration.userinfo"))
        if user.phone != data["phone"] and up == 1:
            flash("此手机号码已经存在！请输入正确的手机号码！", "err")
            return redirect(url_for("registration.userinfo"))
        user.name = data["name"],
        user.gender = data["gender"]
        user.id_card = data["id_card"],
        user.phone = data["phone"],
        user.area = data["area"]
        db.session.add(user)
        db.session.commit()
        flash("个人信息修改成功！", "OK")
        return redirect(url_for("registration.userinfo"))
    return render_template("registration/userinfo.html", form=form, user=user)


# # 个人中心2 暂时不用
# @registration.route("/userinfo_edit/", methods=["GET", "POST"])
# def userinfo_edit():
#     user = User.query.filter_by(name="UserTest").first()
#     return render_template("registration/userinfo_edit.html", user=user)


# 修改密码
@registration.route("/change_pwd/", methods=["GET", "POST"])
def change_pwd():
    form = ChangePwdForm()
    user = User.query.filter_by(id=session['user_id']).first_or_404()
    if form.validate_on_submit():
        pass
    return render_template("registration/change_pwd.html", form=form, user=user)


# 登录日志
@registration.route("/userlog/", methods=["GET", "POST"])
def userlog():
    page_data = Userlog.query.join(User).filter(
        Userlog.user_id == session["user_id"]
    ).order_by(
        Userlog.addtime.asc()
    )
    return render_template("registration/userlog.html", page_data=page_data)


# 登录日志
@registration.route("/admission/", methods=["GET", "POST"])
def admission():
    page_data = Userlog.query.join(User).filter(
        Userlog.user_id == User.id
    ).order_by(
        Userlog.addtime.asc()
    )
    return render_template("registration/admission.html", page_data=page_data)


# 图书
@registration.route("/book/", methods=["GET", "POST"])
def book():
    return render_template("registration/book.html")
