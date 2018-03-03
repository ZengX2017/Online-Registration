# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

import os
import datetime
import uuid
import stat

from flask import render_template, redirect, url_for, flash, session, request, abort
from werkzeug.utils import secure_filename  # 安全修改文件名
from functools import wraps
from app.admin.forms import NewsCategoryForm, NewsTagForm, NewsInfoForm, TlevelForm, TsubjectForm, RefbookForm, \
    TinfoForm, LoginForm, ChangePwdForm
from app.models import NewsCategory, NewsTag, NewsInfo, Admin, Tlevel, Tsubject, Refbook, Tinfo, Adminlog, \
    Userlog, Oplog
from app import app, db
from . import admin


# 访问控制，登录装饰器
def login_req(f):
    """访问控制
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "admin" not in session:
            return redirect(url_for("admin.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


# 修改文件名称
def change_filename(filename):
    fileinfo = os.path.splitext(filename)
    filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + str(uuid.uuid4().hex) + fileinfo[-1]
    return filename


# 首页
@admin.route("/")
def index():
    return render_template("admin/index.html")


# 登录
@admin.route("/login/", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        admin = Admin.query.filter_by(name=data["name"]).first()
        if not admin.check_pwd(data["pwd"]):
            flash("密码错误！", "err")  # 闪现
            return redirect(url_for("admin.login"))
        session["admin"] = data["name"]
        session["admin_id"] = admin.id
        adminlog = Adminlog(
            admin_id=admin.id,
            ip=request.remote_addr
        )
        db.session.add(adminlog)
        db.session.commit()
        return redirect(request.args.get("next") or url_for("admin.index"))
    return render_template("admin/login.html", form=form)


# 注销
@admin.route("/logout/")
def logout():
    session.pop("admin", None)
    session.pop("admin_id", None)
    return redirect(url_for("admin.login"))


# 修改密码
@admin.route("/change_pwd/", methods=["GET", "POST"])
def change_pwd():
    form = ChangePwdForm()
    if form.validate_on_submit():
        data = form.data
        admin = Admin.query.filter_by(name=session["admin"]).first()
        from werkzeug.security import generate_password_hash
        admin.pwd = generate_password_hash(data["new_pwd"])
        db.session.add(admin)
        db.session.commit()
        flash("修改密码成功，请重新登录！", "OK")
        return redirect(url_for('admin.logout'))
    return render_template("admin/change_pwd.html", form=form)


# 新闻类别添加
@admin.route("/newscategory/add/", methods=["GET", "POST"])
def newscategory_add():
    form = NewsCategoryForm()
    if form.validate_on_submit():
        data = form.data
        nc = NewsCategory.query.filter_by(name=data["name"]).count()
        if nc == 1:
            flash("名称已经存在！不能重复添加", "err")
            return redirect(url_for("admin.newscategory_add"))
        nc = NewsCategory(
            name=data["name"]
        )
        db.session.add(nc)
        db.session.commit()
        flash("添加类别成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了新闻类别，名为：%s" % (data["name"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.newscategory_add"))
    return render_template("admin/newscategory_add.html", form=form)


# 新闻类别删除
@admin.route("/newscategory/del/<int:id>/", methods=["GET"])
def newscategory_del(id=None):
    newscategory = NewsCategory.query.filter_by(id=id).first_or_404()
    name = newscategory.name
    db.session.delete(newscategory)
    db.session.commit()
    flash("删除类别成功", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了新闻类别，名为：%s" % name
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.newscategory_list"))


# 新闻类别编辑
@admin.route("/newscategory/edit/<int:id>/", methods=["GET", "POST"])
def newscategory_edit(id=None):
    form = NewsCategoryForm()
    newscategory = NewsCategory.query.get_or_404(id)
    if form.validate_on_submit():
        data = form.data
        nc = NewsCategory.query.filter_by(name=data["name"]).count()
        old_name = data["name"]
        if newscategory.name != data["name"] and nc == 1:
            flash("名称已经存在！", "err")
            return redirect(url_for("admin.newscategory_edit", id=id))
        newscategory.name = data["name"]
        db.session.add(newscategory)
        db.session.commit()
        flash("修改类别成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="修改了新闻类别，原类别名为：%s，新类别名为：%s" % (old_name, data["name"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.newscategory_edit", id=id))
    return render_template("admin/newscategory_edit.html", form=form, newscategory=newscategory)


# 新闻类别列表
@admin.route("/newscategory/list/", methods=["GET"])
def newscategory_list():
    page_data = NewsCategory.query.all()
    return render_template("admin/newscategory_list.html", page_data=page_data)


# 新闻标签添加
@admin.route("/newstag/add/", methods=["GET", "POST"])
def newstag_add():
    form = NewsTagForm()
    # 每次刷新列表
    form.category.choices = [(v.id, v.name) for v in NewsCategory.query.all()]
    if form.validate_on_submit():
        data = form.data
        nt = NewsTag.query.filter_by(name=data["name"]).count()
        if nt == 1:
            flash("此标签名已经存在！不能重复添加", "err")
            return redirect(url_for("admin.newstag_add"))
        newstag = NewsTag(
            name=data["name"],
            newscategory_id=data["category"]
        )
        db.session.add(newstag)
        db.session.commit()
        flash("添加标签成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了新闻标签，名为：%s" % (data["name"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.newstag_add"))
    return render_template("admin/newstag_add.html", form=form)


# 新闻标签列表
@admin.route("/newstag/list/", methods=["GET"])
def newstag_list():
    page_data = NewsTag.query.join(NewsCategory).filter(
        NewsCategory.id == NewsTag.newscategory_id
    ).order_by(
        NewsTag.addtime.asc()
    )
    return render_template("admin/newstag_list.html", page_data=page_data)


# 新闻标签编辑
@admin.route("/newstag/edit/<int:id>/", methods=["GET", "POST"])
def newstag_edit(id=None):
    form = NewsTagForm()
    # 每次刷新列表
    form.category.choices = [(v.id, v.name) for v in NewsCategory.query.all()]
    newstag = NewsTag.query.get_or_404(id)
    old_category = newstag.newscategory.name
    old_name = newstag.name
    if request.method == "GET":
        form.name.data = newstag.name
        form.category.data = newstag.newscategory_id
    if form.validate_on_submit():
        data = form.data
        nt = NewsTag.query.filter_by(name=data["name"]).count()
        if newstag.name != data["name"] and nt == 1:
            flash("此标签名已经存在！", "err")
            return redirect(url_for("admin.newstag_edit", id=id))
        newstag.name = data["name"]
        newstag.newscategory_id = data["category"]
        new_name = data["name"]
        new_category = NewsCategory.query.filter_by(id=data["category"]).first().name  # 根据id找到新的类别名称
        db.session.add(newstag)
        db.session.commit()
        flash("修改标签成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="修改了新闻标签，原标签名为：%s，新标签名为：%s。原所属类别为：%s，新所属类别为：%s。" % (
                old_name, new_name, old_category, new_category)
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.newstag_edit", id=id))
    return render_template("admin/newstag_edit.html", form=form, newstag=newstag)


# 新闻标签删除
@admin.route("/newstag/del/<int:id>/", methods=["GET"])
def newstag_del(id=None):
    newstag = NewsTag.query.filter_by(id=id).first_or_404()
    name = newstag.name
    db.session.delete(newstag)
    db.session.commit()
    flash("删除标签成功", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了新闻标签，名为：%s" % name
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.newstag_list"))


# 新闻资讯添加
@admin.route("/newsinfo/add/", methods=["GET", "POST"])
def newsinfo_add():
    form = NewsInfoForm()
    form.tag.choices = [(nt.id, nt.name) for nt in NewsTag.query.all()]
    if form.validate_on_submit():
        data = form.data
        ni = NewsInfo.query.filter_by(title=data["title"]).count()
        if ni == 1:
            flash("此标题已经存在！不能重复添加", "err")
            return redirect(url_for("admin.newsinfo_add"))
        img_list = ""
        for imgs in request.files.getlist('img'):
            info_img = secure_filename(imgs.filename)
            if not os.path.exists(app.config["UP_NEWS_INFO_DIR"]):  # 处理文件
                os.makedirs(app.config["UP_NEWS_INFO_DIR"])
                os.chmod(app.config["UP_NEWS_INFO_DIR"],
                         stat.S_IRWXU)  # stat.S_IRWXU − Read, write, and execute by owner.
            img = change_filename(info_img)  # 处理文件结束
            img_list = img_list + img + ";"
            form.img.data.save(app.config["UP_NEWS_INFO_DIR"] + img)
            # photos.save(form.photo.data, name='demo_dir/demo.')

        # img_items = img_list.split(";")
        # print(img_items)  # 读数据用

        newsinfo = NewsInfo(
            title=data["title"],
            content=data["info"],
            view_num=0,
            admin_id=1,
            newstag_id=data["tag"],
            img=img_list,
            remark=data["remark"]
        )
        db.session.add(newsinfo)
        db.session.commit()
        flash("添加资讯成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了新闻资讯，名为：%s" % (data["title"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.newsinfo_add"))
    return render_template("admin/newsinfo_add.html", form=form)


# 新闻资讯列表
@admin.route("/newsinfo/list/", methods=["GET"])
def newsinfo_list():
    page_data = NewsInfo.query.join(Admin).join(NewsTag).filter(
        Admin.id == NewsInfo.admin_id,
        NewsTag.id == NewsInfo.newstag_id
    ).order_by(
        NewsInfo.addtime.asc()
    )
    return render_template("admin/newsinfo_list.html", page_data=page_data)


# 新闻资讯修改
# 待修改
@admin.route("/newsinfo/edit/<int:id>", methods=["GET", "POST"])
def newsinfo_edit(id=None):
    form = NewsInfoForm()
    form.tag.choices = [(nt.id, nt.name) for nt in NewsTag.query.all()]
    newsinfo = NewsInfo.query.get_or_404(id)
    # old_category = NewsInfo.newscategory.name
    # old_name = NewsInfo.name
    if request.method == "GET":
        form.tag.data = newsinfo.newstag_id
    if form.validate_on_submit():
        data = form.data
        ni = NewsInfo.query.filter_by(title=data["title"]).count()
        if ni == 1:
            flash("此标题已经存在！不能重复添加", "err")
            return redirect(url_for("admin.newsinfo_add"))
        img_list = ""
        for imgs in request.files.getlist('img'):
            info_img = secure_filename(imgs.filename)
            if not os.path.exists(app.config["UP_NEWS_INFO_DIR"]):  # 处理文件
                os.makedirs(app.config["UP_NEWS_INFO_DIR"])
                os.chmod(app.config["UP_NEWS_INFO_DIR"],
                         stat.S_IRWXU)  # stat.S_IRWXU − Read, write, and execute by owner.
            img = change_filename(info_img)  # 处理文件结束
            img_list = img_list + img + ";"
            form.img.data.save(app.config["UP_NEWS_INFO_DIR"] + img)
            # photos.save(form.photo.data, name='demo_dir/demo.')

        # img_items = img_list.split(";")
        # print(img_items)  # 读数据用

        newsinfo = NewsInfo(
            title=data["title"],
            content=data["info"],
            view_num=0,
            admin_id=1,
            newstag_id=data["tag"],
            img=img_list,
            remark=data["remark"]
        )
        db.session.add(newsinfo)
        db.session.commit()
        flash("添加资讯成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了新闻资讯，名为：%s" % (data["title"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.newsinfo_edit"))
    return render_template("admin/newsinfo_edit.html", form=form, newsinfo=newsinfo)


# 考试级别添加
@admin.route("/tlevel/add/", methods=["GET", "POST"])
def tlevel_add():
    form = TlevelForm()
    if form.validate_on_submit():
        data = form.data
        tl = Tlevel.query.filter_by(level=data["level"]).count()
        if tl == 1:
            flash("此级别已经存在！不能重复添加", "err")
            return redirect(url_for("admin.tlevel_add"))
        tlevel = Tlevel(
            level=data["level"]
        )
        db.session.add(tlevel)
        db.session.commit()
        flash("添加级别成功", "OK")
        return redirect(url_for("admin.tlevel_add"))
    return render_template("admin/tlevel_add.html", form=form)


# 考试级别列表
@admin.route("/tlevel/list/", methods=["GET"])
def tlevel_list():
    page_data = Tlevel.query.order_by(
        Tlevel.addtime.asc()
    )
    return render_template("admin/tlevel_list.html", page_data=page_data)


# 考试科目添加
@admin.route("/tsubject/add/", methods=["GET", "POST"])
def tsubject_add():
    form = TsubjectForm()
    if form.validate_on_submit():
        data = form.data
        ts = Tsubject.query.filter_by(subject=data["subject"]).count()
        if ts == 1:
            flash("此科目已经存在！不能重复添加", "err")
            return redirect(url_for("admin.tsubject_add"))
        tsubject = Tsubject(
            subject=data["subject"]
        )
        db.session.add(tsubject)
        db.session.commit()
        flash("添加科目成功", "OK")
        return redirect(url_for("admin.tsubject_add"))
    return render_template("admin/tsubject_add.html", form=form)


# 考试科目列表
@admin.route("/tsubject/list/", methods=["GET"])
def tsubject_list():
    page_data = Tsubject.query.order_by(
        Tsubject.addtime.asc()
    )
    return render_template("admin/tsubject_list.html", page_data=page_data)


# 考试信息添加
@admin.route("/tinfo/add/", methods=["GET", "POST"])
def tinfo_add():
    form = TinfoForm()
    if form.validate_on_submit():
        data = form.data
        area = data["province"] + "-" + data["city"] + "-" + data["school"]
        ti = Tinfo.query.filter_by(
            level_id=data["tlevel"],
            subject_id=data["tsubject"],
            t_time=data["ttime"],
            area=area,
            examroom=data["examroom"]
        ).count()  # 在同一个时间段，不能存在同一级别的考试科目在同一考点的考场上
        if ti == 1:
            flash("此考试信息已经存在！不能重复添加", "err")
            return redirect(url_for("admin.tinfo_add"))
        tinfo = Tinfo(
            level_id=data["tlevel"],
            subject_id=data["tsubject"],
            t_time=data["ttime"],
            area=area,
            examroom=data["examroom"],
            personnum=data["personnum"],
            price=data["price"],
            refbook_id=data["ref_book"]
        )
        db.session.add(tinfo)
        db.session.commit()
        flash("添加考试信息成功", "OK")
        return redirect(url_for("admin.tinfo_add"))
    return render_template("admin/tinfo_add.html", form=form)


# 考试信息列表
@admin.route("/tinfo/list/", methods=["GET"])
def tinfo_list():
    page_data = Tinfo.query.order_by(
        Tinfo.addtime.asc()
    )
    return render_template("admin/tinfo_list.html", page_data=page_data)


# 参考书添加
@admin.route("/refbook/add/", methods=["GET", "POST"])
def refbook_add():
    form = RefbookForm()
    if form.validate_on_submit():
        data = form.data
        isbn = Refbook.query.filter_by(ISBN=data["ISBN"]).count()
        if isbn == 1:
            flash("此ISBN已经存在！不能重复添加", "err")
            return redirect(url_for("admin.refbook_add"))
        pubdate = data["pubdate"]
        year_index = pubdate.find("年")
        month_index = pubdate.find("月")
        day_index = pubdate.find("日")
        pubdate = pubdate[:year_index] + "-" + pubdate[year_index + 1:month_index] + "-" + pubdate[
                                                                                           month_index + 1:day_index]

        logo_img = secure_filename(form.logo.data.filename)
        if not os.path.exists(app.config["UP_BOOK_DIR"]):  # 处理文件
            os.makedirs(app.config["UP_BOOK_DIR"])
            os.chmod(app.config["UP_BOOK_DIR"], stat.S_IRWXU)  # stat.S_IRWXU − Read, write, and execute by owner.
        logo = change_filename(logo_img)  # 处理文件结束
        form.logo.data.save(app.config["UP_BOOK_DIR"] + logo)

        refbook = Refbook(
            title=data["title"],
            author=data["author"],
            ISBN=data["ISBN"],
            public=data["public"],
            pages=data["pages"],
            logo=logo,
            price=data["price"],
            pubdate=pubdate
        )
        db.session.add(refbook)
        db.session.commit()
        flash("添加参考书成功", "OK")
        return redirect(url_for("admin.refbook_add"))
    return render_template("admin/refbook_add.html", form=form)


# 参考书列表
@admin.route("/refbook/list/", methods=["GET"])
def refbook_list():
    page_data = Refbook.query.order_by(
        Refbook.addtime.asc()
    )
    return render_template("admin/refbook_list.html", page_data=page_data)


# 用户信息列表
@admin.route("/user/list/", methods=["GET"])
def user_list():
    return render_template("admin/user_list.html")


# 管理员登录日志列表
@admin.route("/admin_log_list/", methods=["GET"])
def admin_log():
    page_data = Adminlog.query.join(
        Admin
    ).filter(
        Admin.id == Adminlog.admin_id
    ).order_by(
        Adminlog.addtime.asc()
    )
    return render_template("admin/admin_log.html", page_data=page_data)


# 操作日志列表
@admin.route("/oplog_list/", methods=["GET"])
def oplog_list():
    page_data = Oplog.query.order_by(
        Oplog.addtime.asc()
    )
    return render_template("admin/oplog.html", page_data=page_data)


# 用户登录日志列表
@admin.route("/user_log_list/", methods=["GET"])
def user_log():
    page_data = Userlog.query.order_by(
        Userlog.addtime.asc()
    )
    return render_template("admin/user_log.html", page_data=page_data)


# 管理员信息添加
@admin.route("/admin_add/", methods=["GET", "POST"])
def admin_add():
    return render_template("admin/admin_add.html")


# 管理员信息列表
@admin.route("/admin_list/", methods=["GET"])
def admin_list():
    return render_template("admin/admin_list.html")
