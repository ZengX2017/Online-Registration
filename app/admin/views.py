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
    Userlog, Oplog, User
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
@login_req
def index():
    oplog_list = Oplog.query.order_by(
        Oplog.addtime.asc()
    )
    user_count = User.query.count()
    oplog_book_list = oplog_list.filter(Oplog.opdetail.like('%参考书%'))
    oplog_book_list = oplog_book_list[oplog_book_list.count() - 3:]
    oplog_book_list.reverse()
    oplog_news_list = oplog_list.filter(Oplog.opdetail.like('%新闻%'))
    oplog_news_list = oplog_news_list[oplog_news_list.count() - 3:]
    oplog_news_list.reverse()
    oplog_test_list = oplog_list.filter(Oplog.opdetail.like('%考试%'))
    oplog_test_list = oplog_test_list[oplog_test_list.count() - 3:]
    oplog_test_list.reverse()
    return render_template("admin/index.html", oplog_book_list=oplog_book_list, oplog_news_list=oplog_news_list,
                           oplog_test_list=oplog_test_list, user_count=user_count)


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
@login_req
def logout():
    session.pop("admin", None)
    session.pop("admin_id", None)
    return redirect(url_for("admin.login"))


# 修改密码
@admin.route("/change_pwd/", methods=["GET", "POST"])
@login_req
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


'''
以下是新闻类别（newscategory）的add，del，edit，list四个方法
'''


# 新闻类别添加
@admin.route("/newscategory/add/", methods=["GET", "POST"])
@login_req
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
@login_req
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
@login_req
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
@login_req
def newscategory_list():
    page_data = NewsCategory.query.all()
    return render_template("admin/newscategory_list.html", page_data=page_data)


'''
以下是新闻标签（newstag）的add，del，edit，list四个方法
'''


# 新闻标签添加
@admin.route("/newstag/add/", methods=["GET", "POST"])
@login_req
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


# 新闻标签删除
@admin.route("/newstag/del/<int:id>/", methods=["GET"])
@login_req
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


# 新闻标签编辑
@admin.route("/newstag/edit/<int:id>/", methods=["GET", "POST"])
@login_req
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


# 新闻标签列表
@admin.route("/newstag/list/", methods=["GET"])
@login_req
def newstag_list():
    page_data = NewsTag.query.join(NewsCategory).filter(
        NewsCategory.id == NewsTag.newscategory_id
    ).order_by(
        NewsTag.addtime.asc()
    )
    return render_template("admin/newstag_list.html", page_data=page_data)


'''
以下是新闻资讯（newsinfo）的add，del，edit，list四个方法
'''


# 新闻资讯添加
@admin.route("/newsinfo/add/", methods=["GET", "POST"])
@login_req
def newsinfo_add():
    form = NewsInfoForm()
    form.tag.choices = [(nt.id, nt.name) for nt in NewsTag.query.all()]
    form.remark.data = "声明：本网所刊载的所有信息，包括文字、图片、软件、声音、相片、录相、图表，广告、商业信息及电子邮件" \
                       "的全部内容，除特别标明之外，版权归中国计算机技术职业资格网所有。未经本网的明确书面许可，任何单位或" \
                       "个人不得以任何方式作全部或局部复制、转载、引用，再造或创造与该内容有关的任何派生产品，否则本网将追究其法律责任。 本网凡特别注明稿件来源的文/图等稿件为转载稿，" \
                       "本网转载出于传递更多信息之目的，并不意味着赞同其观点或证实其内容的真实性。" \
                       "如对稿件内容有疑议，请及时与我们联系。 如本网转载稿涉及版权问题，请作者在两周内速来电或来函与我们联系，我们将及时按作者意愿予以更正。"
    if form.validate_on_submit():
        data = form.data
        ni = NewsInfo.query.filter_by(title=data["title"]).count()
        if ni == 1:
            flash("此标题已经存在！不能重复添加", "err")
            return redirect(url_for("admin.newsinfo_add"))
        img = ""
        if form.img.data != "":
            info_img = secure_filename(form.img.data.filename)
            if not os.path.exists(app.config["UP_NEWS_INFO_DIR"]):  # 处理文件
                os.makedirs(app.config["UP_NEWS_INFO_DIR"])
                os.chmod(app.config["UP_NEWS_INFO_DIR"], stat.S_IRWXU)
                # stat.S_IRWXU − Read, write, and execute by owner.
            img = change_filename(info_img)  # 处理文件结束
            form.img.data.save(app.config["UP_NEWS_INFO_DIR"] + img)

        newsinfo = NewsInfo(
            title=data["title"],
            content=data["info"],
            view_num=0,
            admin_id=1,
            newstag_id=data["tag"],
            img=img,
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


# 新闻资讯删除
@admin.route("/newsinfo/del/<int:id>/", methods=["GET"])
@login_req
def newsinfo_del(id=None):
    newsinfo = NewsInfo.query.filter_by(id=id).first_or_404()
    title = newsinfo.title
    db.session.delete(newsinfo)
    db.session.commit()
    flash("删除资讯成功", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了新闻资讯，标题为：%s" % title
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.newsinfo_list"))


# 新闻资讯编辑
# 由于内容，图片之类的难以说明，故资讯只对标题进行操作记录
@admin.route("/newsinfo/edit/<int:id>", methods=["GET", "POST"])
@login_req
def newsinfo_edit(id=None):
    form = NewsInfoForm()
    form.tag.choices = [(nt.id, nt.name) for nt in NewsTag.query.all()]
    newsinfo = NewsInfo.query.get_or_404(id)
    old_title = newsinfo.title
    image = newsinfo.img
    if request.method == "GET":
        form.tag.data = newsinfo.newstag_id
        form.remark.data = newsinfo.remark
    if form.validate_on_submit():
        data = form.data
        ni = NewsInfo.query.filter_by(title=data["title"]).count()
        if newsinfo.title != data["title"] and ni == 1:
            flash("此标题已经存在！不能重复添加", "err")
            return redirect(url_for("admin.newsinfo_edit", id=id))
        if form.img.data != "":
            info_img = secure_filename(form.img.data.filename)
            if not os.path.exists(app.config["UP_NEWS_INFO_DIR"]):  # 处理文件
                os.makedirs(app.config["UP_NEWS_INFO_DIR"])
                os.chmod(app.config["UP_NEWS_INFO_DIR"],
                         stat.S_IRWXU)  # stat.S_IRWXU − Read, write, and execute by owner.
            img = change_filename(info_img)  # 处理文件结束
            form.img.data.save(app.config["UP_NEWS_INFO_DIR"] + img)
            newsinfo.img = img

        newsinfo.title = data["title"]
        newsinfo.content = data["info"]
        newsinfo.newstag_id = data["tag"]
        newsinfo.remark = data["remark"]
        db.session.add(newsinfo)
        db.session.commit()
        flash("修改资讯成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="修改了新闻资讯，原标题名为：%s，新标题名为：%s" % (old_title, data["title"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.newsinfo_edit", id=id))
    return render_template("admin/newsinfo_edit.html", form=form, newsinfo=newsinfo, image=image)


# 新闻资讯列表
@admin.route("/newsinfo/list/", methods=["GET"])
@login_req
def newsinfo_list():
    page_data = NewsInfo.query.join(Admin).join(NewsTag).filter(
        Admin.id == NewsInfo.admin_id,
        NewsTag.id == NewsInfo.newstag_id
    ).order_by(
        NewsInfo.addtime.asc()
    )
    return render_template("admin/newsinfo_list.html", page_data=page_data)


'''
以下是考试级别（tlevel）的add，del，edit，list四个方法
'''


# 考试级别添加
@admin.route("/tlevel/add/", methods=["GET", "POST"])
@login_req
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
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了考试级别，级别名为：%s" % (data["level"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.tlevel_add"))
    return render_template("admin/tlevel_add.html", form=form)


# 考试级别删除
@admin.route("/tlevel/del/<int:id>/", methods=["GET"])
@login_req
def tlevel_del(id=None):
    tlevel = Tlevel.query.filter_by(id=id).first_or_404()
    level = tlevel.level
    db.session.delete(tlevel)
    db.session.commit()
    flash("删除级别成功", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了考试级别，级别名为：%s" % level
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.tlevel_list"))


# 考试级别编辑
@admin.route("/tlevel/edit/<int:id>/", methods=["GET", "POST"])
@login_req
def tlevel_edit(id=None):
    form = TlevelForm()
    tlevel = Tlevel.query.get_or_404(id)
    old_level = tlevel.level
    if form.validate_on_submit():
        data = form.data
        tl = Tlevel.query.filter_by(level=data["level"]).count()
        if tlevel.level != data["level"] and tl == 1:
            flash("此级别已经存在！不能重复添加", "err")
            return redirect(url_for("admin.tlevel_edit", id=id))
        tlevel.level = data["level"]
        db.session.add(tlevel)
        db.session.commit()
        flash("修改级别成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="修改了考试级别，原级别名为：%s，新级别名为：%s" % (old_level, data["level"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.tlevel_edit", id=id))
    return render_template("admin/tlevel_edit.html", form=form, tlevel=tlevel)


# 考试级别列表
@admin.route("/tlevel/list/", methods=["GET"])
@login_req
def tlevel_list():
    page_data = Tlevel.query.order_by(
        Tlevel.addtime.asc()
    )
    return render_template("admin/tlevel_list.html", page_data=page_data)


'''
以下是考试科目（tsubject）的add，del，edit，list四个方法
'''


# 考试科目添加
@admin.route("/tsubject/add/", methods=["GET", "POST"])
@login_req
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
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了考试科目，科目名为：%s" % (data["subject"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.tsubject_add"))
    return render_template("admin/tsubject_add.html", form=form)


# 考试科目删除
@admin.route("/tsubject/del/<int:id>/", methods=["GET"])
@login_req
def tsubject_del(id=None):
    tsubject = Tsubject.query.filter_by(id=id).first_or_404()
    subject = tsubject.subject
    db.session.delete(tsubject)
    db.session.commit()
    flash("删除科目成功", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了考试科目，科目名为：%s" % subject
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.tsubject_list"))


# 考试科目编辑
@admin.route("/tsubject/edit/<int:id>/", methods=["GET", "POST"])
@login_req
def tsubject_edit(id=None):
    form = TsubjectForm()
    tsubject = Tsubject.query.get_or_404(id)
    old_subject = tsubject.subject
    if form.validate_on_submit():
        data = form.data
        ts = Tsubject.query.filter_by(subject=data["subject"]).count()
        if tsubject.subject != data["subject"] and ts == 1:
            flash("此科目已经存在！不能重复添加", "err")
            return redirect(url_for("admin.tsubject_edit", id=id))
        tsubject.subject = data["subject"]
        db.session.add(tsubject)
        db.session.commit()
        flash("修改科目成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="修改了考试科目，原科目名为：%s，新科目名为：%s" % (old_subject, data["subject"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.tsubject_edit", id=id))
    return render_template("admin/tsubject_edit.html", form=form, tsubject=tsubject)


# 考试科目列表
@admin.route("/tsubject/list/", methods=["GET"])
@login_req
def tsubject_list():
    page_data = Tsubject.query.order_by(
        Tsubject.addtime.asc()
    )
    return render_template("admin/tsubject_list.html", page_data=page_data)


'''
以下是考试信息（tinfo）的add，del，edit，list四个方法
'''


# 考试信息添加
@admin.route("/tinfo/add/", methods=["GET", "POST"])
@login_req
def tinfo_add():
    form = TinfoForm()
    form.tlevel.choices = [(tl.id, tl.level) for tl in Tlevel.query.all()]
    form.tsubject.choices = [(ts.id, ts.subject) for ts in Tsubject.query.all()]
    form.ref_book.choices = [(rb.id, rb.title) for rb in Refbook.query.all()]
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
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了考试信息，级别为：%s，考试科目为：%s，考试时间为：%s，考试地点为：%s" % (
                data["tlevel"], data["tsubject"], str(data["ttime"]), area + "-" + data["examroom"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.tinfo_add"))
    return render_template("admin/tinfo_add.html", form=form)


# 考试信息删除
@admin.route("/tinfo/del/<int:id>/", methods=["GET"])
@login_req
def tinfo_del(id=None):
    tinfo = Tinfo.query.filter_by(id=id).first_or_404()
    tlevel = tinfo.tlevel.level
    tsubject = tinfo.tsubject.subject
    ttime = tinfo.t_time
    area = tinfo.area
    examroom = tinfo.examroom
    db.session.delete(tinfo)
    db.session.commit()
    flash("删除考试信息成功！", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了考试信息，级别为：%s，考试科目为：%s，考试时间为：%s，考试地点为：%s" % (tlevel, tsubject, str(ttime), area + "-" + examroom)
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for('admin.tinfo_list'))


# 考试信息添加
@admin.route("/tinfo/edit/<int:id>/", methods=["GET", "POST"])
@login_req
def tinfo_edit(id=None):
    form = TinfoForm()
    form.tlevel.choices = [(tl.id, tl.level) for tl in Tlevel.query.all()]
    form.tsubject.choices = [(ts.id, ts.subject) for ts in Tsubject.query.all()]
    form.ref_book.choices = [(rb.id, rb.title) for rb in Refbook.query.all()]
    tinfo = Tinfo.query.get_or_404(id)

    if request.method == "GET":
        form.tlevel.data = tinfo.level_id
        form.tsubject.data = tinfo.subject_id
        form.ttime.data = tinfo.t_time
        form.ref_book.data = tinfo.refbook_id

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
            return redirect(url_for("admin.tinfo_edit", id=id))
        tinfo.level_id = data["tlevel"]
        tinfo.subject_id = data["tsubject"]
        tinfo.t_time = data["ttime"]
        tinfo.area = area
        tinfo.examroom = data["examroom"]
        tinfo.personnum = data["personnum"]
        tinfo.price = data["price"]
        tinfo.refbook_id = data["ref_book"]
        db.session.add(tinfo)
        db.session.commit()
        flash("修改考试信息成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="修改了考试信息，级别为：%s，考试科目为：%s，考试时间为：%s，考试地点为：%s" % (
                data["tlevel"], data["tsubject"], str(data["ttime"]), area + "-" + data["examroom"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.tinfo_edit", id=id))
    return render_template("admin/tinfo_edit.html", form=form, tinfo=tinfo)


# 考试信息列表
@admin.route("/tinfo/list/", methods=["GET"])
@login_req
def tinfo_list():
    page_data = Tinfo.query.order_by(
        Tinfo.addtime.asc()
    )
    return render_template("admin/tinfo_list.html", page_data=page_data)


'''
以下是参考书（refbook）的add，del，edit，list四个方法
'''


# 参考书添加
@admin.route("/refbook/add/", methods=["GET", "POST"])
@login_req
def refbook_add():
    form = RefbookForm()
    if form.validate_on_submit():
        data = form.data
        isbn = Refbook.query.filter_by(ISBN=data["ISBN"]).count()
        if isbn == 1:
            flash("此ISBN已经存在！不能重复添加", "err")
            return redirect(url_for("admin.refbook_add"))

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
            pubdate=data["pubdate"],
            info=data["info"]
        )
        db.session.add(refbook)
        db.session.commit()
        flash("添加参考书成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="添加了参考书，书名为：%s，ISBN为：%s" % (data["title"], data["ISBN"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.refbook_add"))
    return render_template("admin/refbook_add.html", form=form)


# 参考书删除
@admin.route("/refbook/del/<int:id>/", methods=["GET"])
@login_req
def refbook_del(id=None):
    refbook = Refbook.query.filter_by(id=id).first_or_404()
    old_title = refbook.title
    old_isbn = refbook.ISBN
    db.session.delete(refbook)
    db.session.commit()
    flash("删除参考书成功", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了参考书，书名为：%s，ISBN为：%s" % (old_title, old_isbn)
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.refbook_list"))


# 参考书编辑
@admin.route("/refbook/edit/<int:id>/", methods=["GET", "POST"])
@login_req
def refbook_edit(id=None):
    form = RefbookForm()
    refbook = Refbook.query.get_or_404(id)
    form.logo.validators = []  # 取消掉参考书中封面的验证
    old_title = refbook.title
    old_ISBN = refbook.ISBN
    if request.method == "GET":
        form.pubdate.data = refbook.pubdate
        form.info.data = refbook.info

    if form.validate_on_submit():
        data = form.data
        isbn = Refbook.query.filter_by(ISBN=data["ISBN"]).count()
        if refbook.ISBN != data["ISBN"] and isbn == 1:
            flash("此ISBN已经存在！不能重复添加", "err")
            return redirect(url_for("admin.refbook_edit", id=id))

        if form.logo.data != "":
            book_logo = secure_filename(form.logo.data.filename)
            refbook.logo = change_filename(book_logo)
            form.logo.data.save(app.config["UP_BOOK_DIR"] + refbook.logo)

        refbook.title = data["title"]
        refbook.author = data["author"]
        refbook.public = data["public"]
        refbook.pages = data["pages"]
        refbook.price = data["price"]
        refbook.pubdate = data["pubdate"]
        refbook.info = data["info"]
        db.session.add(refbook)
        db.session.commit()
        flash("修改参考书成功", "OK")
        oplog = Oplog(
            admin_id=session["admin_id"],
            ip=request.remote_addr,
            opdetail="修改了参考书，原书名为：%s，原ISBN为：%s。现书名为：%s，现ISBN为：%s" % (old_title, old_ISBN, data["title"], data["ISBN"])
        )
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for("admin.refbook_edit", id=id))
    return render_template("admin/refbook_edit.html", form=form, refbook=refbook)


# 参考书列表
@admin.route("/refbook/list/", methods=["GET"])
@login_req
def refbook_list():
    page_data = Refbook.query.order_by(
        Refbook.addtime.asc()
    )
    return render_template("admin/refbook_list.html", page_data=page_data)


'''
以下是用户（user）的info，del，list三个方法
'''


# 用户信息查看
@admin.route("/user/info/<int:id>/", methods=["GET"])
@login_req
def user_info(id=None):
    user = User.query.get_or_404(id)
    return render_template("admin/user_info.html", user=user)


# 用户信息删除
@admin.route("/user/del/<int:id>/", methods=["GET"])
@login_req
def user_del(id=None):
    user = User.query.filter_by(id=id).first_or_404()
    name = user.name
    email = user.email
    db.session.delete(user)
    db.session.commit()
    flash("删除用户成功", "OK")
    oplog = Oplog(
        admin_id=session["admin_id"],
        ip=request.remote_addr,
        opdetail="删除了用户，姓名为：%s，账号为：%s" % (name, email)
    )
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.user_list"))


# 用户信息列表
@admin.route("/user/list/", methods=["GET"])
@login_req
def user_list():
    page_data = User.query.order_by(
        User.addtime.asc()
    )
    return render_template("admin/user_list.html", page_data=page_data)


'''
以下是日志（log）的admin_log，oplog_list，user_log三个方法
'''


# 管理员登录日志列表
@admin.route("/admin_log_list/", methods=["GET"])
@login_req
def admin_log():
    page_data = Adminlog.query.join(
        Admin
    ).filter(
        Admin.id == session["admin_id"]
    ).order_by(
        Adminlog.addtime.asc()
    )
    return render_template("admin/admin_log.html", page_data=page_data)


# 操作日志列表
@admin.route("/oplog_list/", methods=["GET"])
@login_req
def oplog_list():
    page_data = Oplog.query.order_by(
        Oplog.addtime.asc()
    )
    return render_template("admin/oplog.html", page_data=page_data)


# 用户登录日志列表
@admin.route("/user_log_list/", methods=["GET"])
@login_req
def user_log():
    page_data = Userlog.query.order_by(
        Userlog.addtime.asc()
    )
    return render_template("admin/user_log.html", page_data=page_data)


'''
以下是管理员（admin）的add，list两个方法，考虑舍弃
'''


# 管理员信息添加
@admin.route("/admin_add/", methods=["GET", "POST"])
@login_req
def admin_add():
    return render_template("admin/admin_add.html")


# 管理员信息列表
@admin.route("/admin_list/", methods=["GET"])
@login_req
def admin_list():
    page_data = Admin.query.order_by(
        Admin.addtime.asc()
    )
    return render_template("admin/admin_list.html", page_data=page_data)

