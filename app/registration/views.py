# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import render_template, redirect, url_for, flash, session, request, abort
from app.registration.forms import RegisterForm, LoginForm, UserInfoForm, ChangePwdForm, AdviceForm, ForgetPwdForm
from app.models import User, Userlog, NewsInfo, NewsTag, NewsCategory, Refbook, Tinfo, Trinfo, Admission
from app import app, db, mail
from functools import wraps
from werkzeug.utils import secure_filename  # 安全修改文件名
from werkzeug.security import generate_password_hash
from flask_mail import Message
from threading import Thread
from sqlalchemy import distinct
from . import registration
import datetime
import os
import stat
import uuid
import random


# 异步发送邮件
def send_async_email(app, msg):
    with app.app_context():
        mail.send(msg)


# 访问控制，登录装饰器
def login_req(f):
    """访问控制
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "user" not in session:
            return redirect(url_for("registration.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


'''
理解本方法（affairs_public_tags）：
    因为政务公开栏挂在右侧，在网页中是用Jinja2的语法：include进行加载的，为了让数据从数据库读出来以及减少重复性，故写出了本方法。
在数据库的NewsCategory下有政务公开数据时返回为政务公开和及其下面的标签，若没有此值，则返回空。不过不用当心前台右侧会不出现任何东
西，前台会根据空时显示设置号的静态类别和标签。
'''


# 政务公开栏
def affairs_public_tags():
    zwgkNc = NewsCategory.query.filter_by(name="政务公开").first_or_404()
    if not zwgkNc:
        return None, None
    zwgkTags = NewsTag.query.filter_by(newscategory_id=zwgkNc.id)
    return zwgkNc.name, zwgkTags


'''
理解本方法（index_length）：
    本方法本来是在index_infos方法里面的，后来因为好几个部分不能调用infos方法但都有此逻辑，故将此部分从index_infos方法
抽出重建。
    注：为了避免多次写reverse()，在方法内部封装了此方法，返回翻转后的数据列表
'''


def index_length(result=None, length=None):  # 将数据集转为列表，目的是为了翻转
    if result.count() <= int(length):
        result = result[:]  # 小于等于length(举例：6）条数据全部显示
    else:
        result = result[result.count() - int(length):]  # 大于length(举例：6）条数据显示最新的前length(举例：6）条（需要翻转）
    result.reverse()  # 先加上，后期再看，如果不方便再去掉
    return result


'''
理解本方法（index_infos）：
    因为首页大多数内容都有一样的显示方式，即小于等于length(举例：6）条数据全部显示，大于length(举例：6）条数据
显示最新的前length(举例：6）条（需要翻转），为了避免多余的重复代码，故在此写本方法减少代码的重复率。
    注：注释部分被抽出成为index_length()方法。
    原意是为了解决级别tablist而设计的，在此基础上对外扩展，成为了部分内容都可用的方法    
'''


def index_infos(name=None, length=None):
    infos = NewsTag.query.filter_by(name=name).first_or_404()  # 找出name所在的tag_id
    infos = NewsInfo.query.filter_by(newstag_id=infos.id)  # 找出name级别的所有数据
    infos = index_length(infos, length)
    # if infos.count() <= int(length):
    #     infos = infos[:]  # 不超过length条数据则全部显示
    # else:
    #     infos = infos[infos.count() - int(length):]  # 超过length条数据后选最后length-1条数据出现
    return infos


'''
理解本方法（latest_infos）：
    本方法为展示动态最新通知
'''


def latest_Infos(length=None):
    latest_infos = NewsInfo.query.order_by(NewsInfo.addtime.desc())  # 降序找出最新通知消息
    latest_infos = latest_infos[:length]  # 切片，找出前length条
    return latest_infos


# 修改文件名称
def change_filename(filename):
    fileinfo = os.path.splitext(filename)
    filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + str(uuid.uuid4().hex) + fileinfo[-1]
    return filename


'''
理解本方法（nav_tags）：
    本方法是为了将导航上的子项设置为动态项，目的是为了像政务公开那样显示数据。统一风格
'''


# nav动态标签
def nav_tags(name):
    tags_name = NewsCategory.query.filter_by(name=name).first_or_404()
    item_tags = NewsTag.query.filter(
        NewsTag.newscategory_id == tags_name.id
    )
    return item_tags


# 首页
@registration.route("/")
def index():
    newsinfos = NewsInfo.query.order_by(NewsInfo.addtime.asc())
    newstag = NewsTag.query.filter_by(name="公告栏").first_or_404()  # 找出公告栏所在newstag表中的数据
    newstags = newsinfos.join(NewsTag).filter(
        NewsTag.id == newstag.id
    )  # 找出newsinfo表中隶属公告栏的数据

    newstags = index_length(newstags, 5)

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍

    # 最新通知
    latest_infos = latest_Infos(10)

    # 轮播图，NewsInfo，本来打算用Newsinfo.img.isnot(None)来找出img字段不为空的newsinfo，但是用此方法找出来的是所有的info，故舍弃
    banner = newsinfos.filter(NewsInfo.img.ilike("20%"))
    banner = index_length(banner, 3)

    # 级别tablist
    primary = index_infos("初级", 6)  # 详见方法index_infos()上方说明
    middle = index_infos("中级", 6)
    advanced = index_infos("高级", 6)

    # 考试信息
    tinfos = Tinfo.query.order_by(
        Tinfo.t_time.asc()
    )
    tinfos = index_length(tinfos, 5)
    distinct_list = []  # 去重列表
    tinfo = []  # 去重后得到的对象列表
    for va in tinfos:  # for循环为去重操作
        tu = (va.level_id, va.subject_id)
        if tu not in distinct_list:
            distinct_list.append(tu)
            tinfo.append(va)
    tinfos = tinfo

    # tinfos = Tinfo.query.filter(Tinfo.refbook_id.isnot(None))
    # tinfos = index_length(tinfos, 5)

    # 尾部信息
    reg_infos = index_infos("报名安排", 5)

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/index.html", newstags=newstags, gzdt_tags=gzdt_tags, zwgkNc=zwgkNc,
                           zwgkTags=zwgkTags, ksgs_tags=ksgs_tags, djjs_tags=djjs_tags, latest_infos=latest_infos,
                           banner=banner, primary=primary, middle=middle, advanced=advanced, tinfos=tinfos,
                           reg_infos=reg_infos)


'''
理解本方法（search）：
    本方法为搜索功能，从前台导航栏的搜索框获取输入的key去数据库查找，只需要改一条语句即可实现不同的功能。鉴于毕业设计任务书要求实现的是
参考书的搜索功能，故将功能设置为参考书的搜索功能。写此功能时初始实现的是搜索新闻资讯，代码如下：
    newsinfos = NewsInfo.query.filter(NewsInfo.title.ilike('%' + info + '%'))
    方法内的newsinfos为了避免在search.html和本方法内进行修改，就不设置为refbooks了
'''


# 搜索
@registration.route("/search/")
def search():
    info = request.args.get("info", "")
    newsinfos = Refbook.query.filter(Refbook.title.ilike('%' + info + '%'))
    count = newsinfos.count()
    newsinfos = index_length(newsinfos, count)

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/search.html", newsinfos=newsinfos, info=info, count=count, zwgkNc=zwgkNc,
                           gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags, djjs_tags=djjs_tags, zwgkTags=zwgkTags)


# 参考书详情
@registration.route("/refbook_detail/<int:id>", methods=["GET"])
def refbook_detail(id=None):
    refbook = Refbook.query.get_or_404(id)

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/refbook_detail.html", refbook=refbook, gzdt_tags=gzdt_tags,
                           ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


'''
理解本方法（newscategory）：
    在nav.html页中用get方式取得标签，然后在本方法中润色，通过传递过来的标签（具有唯一性）进行数据查找
    找到name所对应的newstag，然后再根据newstag去取得所属类别，通过Jinja2模板渲染在前台。
    此处加newstag_name的作用有3，一是面包屑导航栏的显示，二是根据判断newstags的tag是否为当前name，是的话加上active
    三是左侧小导航的显示和中间面板主体左上角的显示    
'''


# 资讯标签和类别相关
@registration.route("/newscategory/<name>/", methods=["GET"])
def newscategory(name):
    newstag = NewsTag.query.filter_by(name=name).first_or_404()  # 通过nav请求找到tag
    newstag_name = name  # 存下当前请求的name
    newscategory = newstag.newscategory.name  # 根据当前tag找到所属类别，为了面包屑导航栏的一级显示
    newscategorys = NewsCategory.query.filter_by(name=newscategory).first_or_404()  # 找出当前所属类别的id
    newstags = NewsTag.query.filter_by(newscategory_id=newscategorys.id)  # 根据所属类别的id找出此类别下所有的标签
    newsinfos = NewsInfo.query.filter_by(newstag_id=newstag.id).order_by(
        NewsInfo.addtime.asc()
    )  # 根据当前标签找出此标签下的所有内容

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    newsinfos = index_length(newsinfos, newsinfos.count())

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/newscategory.html", newstag=newstag, newstag_name=newstag_name,
                           newscategory=newscategory, newstags=newstags, newsinfos=newsinfos, ksgs_tags=ksgs_tags,
                           gzdt_tags=gzdt_tags, djjs_tags=djjs_tags, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


'''
理解本方法（detail）：
    本方法分2部分，一部分根据是大多数信息的id去newsinfo中找到并读出。第二部分也是新增的部分，为了提高代码的覆写率，
在tinfo_detail中的查看介绍根据所传参数的标题去newsinfo里面找。
'''


# 资讯详情
@registration.route("/detail/<id>/", methods=["GET"])
def detail(id=None):
    if id.isdigit():
        newsinfo = NewsInfo.query.get_or_404(int(id))
    else:
        newsinfo = NewsInfo.query.filter_by(title=id).first_or_404()
    newstag = newsinfo.newstag.name
    newscategory = newsinfo.newstag.newscategory.name
    newsinfo.view_num = newsinfo.view_num + 1
    db.session.add(newsinfo)
    db.session.commit()

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/detail.html", newsinfo=newsinfo, newstag=newstag, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags, gzdt_tags=gzdt_tags, newscategory=newscategory, zwgkNc=zwgkNc,
                           zwgkTags=zwgkTags)


'''
理解本方法（tinfo）：
    虽然本方法与newscategory方法几乎一致，但由于展示的数据不一样，newscategory方法展示的是newsinfo，本方法展示的是tinfo
因此本方法独立出来。不仅如此，newscategory方法及其页面涵盖了将近80%的数据，不能为了故意降低代码的重复率而多做动作。
'''


# 考试信息相关
@registration.route("/tinfo/<name>/", methods=["GET"])
def tinfo(name):
    newstag = NewsTag.query.filter_by(name=name).first_or_404()  # 通过nav请求找到tag
    newstag_name = name  # 存下当前请求的name
    newscategory = newstag.newscategory.name  # 根据当前tag找到所属类别，为了面包屑导航栏的一级显示
    newscategorys = NewsCategory.query.filter_by(name=newscategory).first_or_404()  # 找出当前所属类别的id
    newstags = NewsTag.query.filter_by(newscategory_id=newscategorys.id)  # 根据所属类别的id找出此类别下所有的标签
    tinfos = Tinfo.query.order_by(
        Tinfo.t_time.asc()
    )  # 根据当前标签找出此标签下的所有内容
    tinfos = index_length(tinfos, tinfos.count())
    now = datetime.datetime.strptime(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "%Y-%m-%d %H:%M:%S")
    time_diff = datetime.timedelta(days=30)
    time_zero = datetime.timedelta(days=7)

    distinct_list = []  # 去重列表
    tinfo = []  # 去重后得到的对象列表
    for va in tinfos:  # for循环为去重操作
        tu = (va.level_id, va.subject_id)
        if tu not in distinct_list:
            distinct_list.append(tu)
            tinfo.append(va)

    tinfos = tinfo

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/tinfo.html", newstag=newstag, newstag_name=newstag_name,
                           newscategory=newscategory, newstags=newstags, tinfos=tinfos, now=now,
                           time_diff=time_diff, time_zero=time_zero, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


# 考试信息详情
@registration.route("/tinfo_detail/<int:id>/", methods=["GET"])
def tinfo_detail(id=None):
    tinfo = Tinfo.query.get_or_404(id)
    level = tinfo.tlevel.level
    subject = tinfo.tsubject.subject
    now = datetime.datetime.strptime(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "%Y-%m-%d %H:%M:%S")
    time_diff = datetime.timedelta(days=7)

    tinfo = Tinfo.query.filter(
        Tinfo.level_id == tinfo.level_id,
        Tinfo.subject_id == tinfo.subject_id
    ).order_by(
        Tinfo.t_time.asc()
    )

    tinfo = index_length(tinfo, tinfo.count())

    latest_infos = latest_Infos(6)

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/tinfo_detail.html", tinfo=tinfo, time_diff=time_diff, now=now,
                           latest_infos=latest_infos, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags, djjs_tags=djjs_tags,
                           zwgkNc=zwgkNc, zwgkTags=zwgkTags, level=level, subject=subject)


# 考试报名信息详情
@registration.route("/trinfo/<int:id>/", methods=["GET"])
@login_req
def trinfo(id=None):
    trinfo = Trinfo.query.filter_by(tinfo_id=id).first_or_404()
    time_diff = datetime.timedelta(days=7)
    now = datetime.datetime.strptime(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "%Y-%m-%d %H:%M:%S")

    latest_infos = latest_Infos(6)

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/trinfo.html", trinfo=trinfo, latest_infos=latest_infos,
                           now=now, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags, djjs_tags=djjs_tags,
                           zwgkNc=zwgkNc, zwgkTags=zwgkTags, time_diff=time_diff)


'''
理解本方法（admission_generate）：
    考试报名信息的id和用户id均由前台请求数据传过来，本方法的前提就是用户已登录，并且考试报名信息合理。
因为trinfo中对用户的登录状态进行了判断，此方法是在trinfo方法中跳转过来实现的，故不用去判断考试报名信息和
用户登录状态    
'''


# 准考证生成
@registration.route("/admission/<trinfo_id>/<user_id>/")
@login_req
def admission_generate(trinfo_id=None, user_id=None):
    user = User.query.get_or_404(int(user_id))
    trinfo = Trinfo.query.get_or_404(int(trinfo_id))  # 找到当前考试报名信息

    if not user.face or not user.id_card:
        flash("请完善您的头像和身份证！", "err")
        return redirect(url_for("registration.userinfo"))  # 完善个人信息

    admission_verify = Admission.query.filter(
        Admission.user_id == user_id,
        Admission.trinfo_id == trinfo_id
    ).count()
    if admission_verify == 1:
        flash("请不要重复报名本场考试！", "err")
        return redirect(url_for("registration.tinfo_detail", id=trinfo.tinfo.id))
        # 根据传过来的2个id查找Admission中有没有出现过此数据，等于1的话说明已经报名成功过，此时重定向至考试信息界面

    dateinfo = trinfo.tinfo.t_time.strftime("%Y%m%d%H%M")  # 12位当前时间信息
    examinfo = trinfo.tinfo.examroom[len(trinfo.tinfo.examroom) - 3:]  # 取后3位数字
    if (trinfo.num + 1) % trinfo.tinfo.personnum == 0:
        seat = trinfo.tinfo.personnum
    else:
        if trinfo.num // 10 == 0:  # 整除
            seat = str(0) + "" + str((trinfo.num + 1) % trinfo.tinfo.personnum)  # 座位号，1到personnum
        else:
            seat = str((trinfo.num + 1) % trinfo.tinfo.personnum)

    admission = Admission(
        admission_id=dateinfo + "0" + examinfo + str(seat),
        trinfo_id=int(trinfo_id),
        status=1,
        user_id=int(user_id),
    )  # 创建准考证
    trinfo.num = trinfo.num + 1  # 报名人数+1
    if trinfo.tinfo.personnum - trinfo.num == 0:  # 判断考试报名人数是否还有余，没有的话显示不可报名
        trinfo.status = 0
    db.session.add(admission)
    db.session.commit()
    db.session.add(trinfo)
    db.session.commit()
    return redirect(url_for("registration.userinfo"))


'''
理解此方法（registration_query）：
    本方法展示的数据为准考证数据库里面的所有内容，先取出数据集合。然后根据当前时间和考试时间进行对比，如果考试时间
比当前时间晚（小），即说明考试已经开始了，此时不能打印准考证。
    注：为了跟公告对应，将时间差控制在7天（一周），若有需要再更改时间差。
'''


# 报名查询
@registration.route("/registration_query/", methods=["GET", "POST"])
@login_req
def registration_query():
    admissions = Admission.query.join(User).filter(
        Admission.user_id == session["user_id"]
    ).order_by(
        Admission.addtime.asc()
    )

    now = datetime.datetime.strptime(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "%Y-%m-%d %H:%M:%S")

    for admission in admissions:
        if admission.trinfo.tinfo.t_time - now < datetime.timedelta(days=7):
            admission.status = 0
            db.session.add(admission)
            db.session.commit()

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/registration_query.html", admissions=admissions, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags)


# 准考证详情
@registration.route("/registration_detail/<int:id>/", methods=["GET"])
@login_req
def registration_detail(id=None):
    admission = Admission.query.get_or_404(id)  # 根据id找出准考证
    seat = admission.admission_id[len(admission.admission_id) - 2:]  # 座位号

    latest_infos = latest_Infos(6)

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/registration_detail.html", admission=admission, seat=seat,
                           latest_infos=latest_infos, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags, djjs_tags=djjs_tags,
                           zwgkNc=zwgkNc, zwgkTags=zwgkTags)


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

        if not data["captcha"]:
            flash("请拖动滑块！", "err")
            return redirect(url_for("registration.login"))

        session["user"] = user.email
        session["user_id"] = user.id
        userlog = Userlog(
            user_id=user.id,
            ip=request.remote_addr,
        )
        db.session.add(userlog)
        db.session.commit()
        return redirect(request.args.get("next") or url_for("registration.userinfo"))  # 登录后返回之前位置实现失败

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/login.html", form=form, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags)


# 用户注销
@registration.route("/logout/")
@login_req
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
        if not data["captcha"]:
            flash("请拖动滑块！", "err")
            return redirect(url_for("registration.register"))

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

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/register.html", form=form, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags)


# 找回密码
@registration.route("/forgetPwd/", methods=["GET", "POST"])
def forgetPwd():
    form = ForgetPwdForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(email=data["email"]).first()
        user_count = User.query.filter_by(email=data["email"]).count()
        if user_count == 0:
            flash("此邮箱未注册！", "err")
            return redirect(url_for('registration.forgetPwd'))
        seed = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+=-"
        sa = []
        for i in range(8):
            sa.append(random.choice(seed))
        new_pwd = ''.join(sa)
        user.pwd = generate_password_hash(new_pwd)  # 重置密码为随机的8位字符

        db.session.add(user)
        db.session.commit()
        flash("您的密码重置成功，请去邮箱检查！", "OK")

        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        msg = Message("密码重置提醒！", sender="adward@adwardz.top")
        msg.add_recipient(data["email"])

        msg.html = "<h1>尊敬的---<font color='red'>" + data["email"] + "</font>---用户！</h1><br>您的密码于" + now + \
                   "已重置，新密码为：<font color='red'>" + new_pwd + \
                   "</font>，请登录后重新修改密码！<br><h1 style='float:right'>来自Adward_Z</h1>"
        thr = Thread(target=send_async_email, args=[app, msg])
        thr.start()
        return redirect(url_for("registration.login"))

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/forgetPwd.html", form=form, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags)


# 个人中心
@registration.route("/userinfo/", methods=["GET", "POST"])
@login_req
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

        if not os.path.exists(app.config["UP_USER_INFO_DIR"]):  # 处理文件
            os.makedirs(app.config["UP_USER_INFO_DIR"])
            os.chmod(app.config["UP_USER_INFO_DIR"], stat.S_IRWXU)  # stat.S_IRWXU − Read, write, and execute by owner.

        if form.face.data != "":
            face_logo = secure_filename(form.face.data.filename)
            user.face = change_filename(face_logo)
            form.face.data.save(app.config["UP_USER_INFO_DIR"] + user.face)
        user.name = data["name"],
        user.gender = data["gender"]
        user.id_card = data["id_card"],
        user.phone = data["phone"],
        user.area = data["area"]
        if data["id_card"]:
            user.id_status = 1
        db.session.add(user)
        db.session.commit()
        flash("个人信息修改成功！", "OK")
        return redirect(url_for("registration.userinfo"))

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/userinfo.html", form=form, user=user, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags)


# 修改密码
@registration.route("/change_pwd/", methods=["GET", "POST"])
@login_req
def change_pwd():
    form = ChangePwdForm()
    user = User.query.filter_by(id=session['user_id']).first_or_404()
    if form.validate_on_submit():
        data = form.data
        user.pwd = generate_password_hash(data["new_pwd"])
        db.session.add(user)
        db.session.commit()
        flash("修改密码成功，请重新登录！", "OK")
        return redirect(url_for('registration.logout'))

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/change_pwd.html", form=form, user=user, gzdt_tags=gzdt_tags,
                           ksgs_tags=ksgs_tags, djjs_tags=djjs_tags)


# 登录日志
@registration.route("/userlog/", methods=["GET", "POST"])
@login_req
def userlog():
    page_data = Userlog.query.join(User).filter(
        Userlog.user_id == session["user_id"]
    ).order_by(
        Userlog.addtime.desc()
    )
    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/userlog.html", page_data=page_data, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags,
                           djjs_tags=djjs_tags)


# 关于我们
@registration.route("/about_us/", methods=["GET", "POST"])
def about_us():
    gzdt_tags = nav_tags("工作动态")  # 工作动态
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    return render_template("registration/about.html", gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags, djjs_tags=djjs_tags,
                           zwgkNc=zwgkNc, zwgkTags=zwgkTags)


# 相关建议
@registration.route("/advice/", methods=["GET", "POST"])
def advice():
    form = AdviceForm()
    if form.validate_on_submit():
        data = form.data
        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        msg = Message("在 " + now + " 收到来自" + data["email"] + "的建议！",
                      sender="adward@adwardz.top", recipients=["adward@adwardz.top"])
        # msg.add_recipient(data["email"])  # 找回密码功能再用
        msg.html = "<h1>邮件功能测试</h1><br>" + data["content"] + "<br><h1>" + data["name"] + "</h1>"
        thr = Thread(target=send_async_email, args=[app, msg])
        thr.start()
        flash("您的建议我们已经收到，谢谢！", "OK")
        return redirect(url_for("registration.advice"))

    gzdt_tags = nav_tags("工作动态")  # 工作动态
    ksgs_tags = nav_tags("考试概述")  # 考试概述
    djjs_tags = nav_tags("等级介绍")  # 等级介绍
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/advice.html", form=form, gzdt_tags=gzdt_tags, ksgs_tags=ksgs_tags, djjs_tags=djjs_tags,
                           zwgkNc=zwgkNc, zwgkTags=zwgkTags)
