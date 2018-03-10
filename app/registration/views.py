# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import render_template, redirect, url_for, flash, session, request, abort
from app.registration.forms import RegisterForm, LoginForm, UserInfoForm, ChangePwdForm
from app.models import User, Userlog, NewsInfo, NewsTag, NewsCategory, Refbook, Tinfo, Trinfo, Admission
from app import app, db
from werkzeug.utils import secure_filename  # 安全修改文件名
from werkzeug.security import generate_password_hash
from . import registration
import datetime
import os
import stat
import uuid


# 政务公开栏
'''
理解本方法（affairs_public_tags）：
    因为政务公开栏挂在右侧，在网页中是用Jinja2的语法：include进行加载的，为了让数据从数据库读出来以及减少重复性，故写出了本方法。
在数据库的NewsCategory下有政务公开数据时返回为政务公开和及其下面的标签，若没有此值，则返回空。不过不用当心前台右侧会不出现任何东
西，前台会根据空时显示设置号的静态类别和标签。
'''


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


# 首页
@registration.route("/")
def index():
    newsinfos = NewsInfo.query.order_by(NewsInfo.addtime.asc())
    newstag = NewsTag.query.filter_by(name="公告栏").first_or_404()  # 找出公告栏所在newstag表中的数据
    newstags = newsinfos.join(NewsTag).filter(
        NewsTag.id == newstag.id
    )  # 找出newsinfo表中隶属公告栏的数据

    newstags = index_length(newstags, 5)

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
    tinfos = Tinfo.query.filter(Tinfo.refbook_id.isnot(None))
    tinfos = index_length(tinfos, 5)

    # 尾部信息
    reg_infos = index_infos("报名安排", 5)

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/index.html", newstags=newstags, zwgkNc=zwgkNc, zwgkTags=zwgkTags,
                           latest_infos=latest_infos, banner=banner, primary=primary, middle=middle,
                           advanced=advanced, tinfos=tinfos, reg_infos=reg_infos)


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

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/search.html", newsinfos=newsinfos, info=info, count=count, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


# 参考书详情
@registration.route("/refbook_detail/<int:id>", methods=["GET"])
def refbook_detail(id=None):
    refbook = Refbook.query.get_or_404(id)
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/refbook_detail.html", refbook=refbook, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


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

    newsinfos = index_length(newsinfos, newsinfos.count())

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/newscategory.html", newstag=newstag, newstag_name=newstag_name,
                           newscategory=newscategory, newstags=newstags, newsinfos=newsinfos,
                           zwgkNc=zwgkNc, zwgkTags=zwgkTags)


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
    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/detail.html", newsinfo=newsinfo, newstag=newstag,
                           newscategory=newscategory, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


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
    now = datetime.datetime.strptime(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "%Y-%m-%d %H:%M:%S")
    time_diff = datetime.timedelta(days=30)
    time_zero = datetime.timedelta(days=1)
    tinfos = index_length(tinfos, tinfos.count())

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/tinfo.html", newstag=newstag, newstag_name=newstag_name,
                           newscategory=newscategory, newstags=newstags, tinfos=tinfos, now=now,
                           time_diff=time_diff, time_zero=time_zero, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


# 考试信息详情
@registration.route("/tinfo_detail/<int:id>/", methods=["GET"])
def tinfo_detail(id=None):
    tinfo = Tinfo.query.get_or_404(id)
    time_diff = datetime.timedelta(days=7)

    latest_infos = latest_Infos(6)

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/tinfo_detail.html", tinfo=tinfo, time_diff=time_diff,
                           latest_infos=latest_infos, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


# 考试报名信息详情
@registration.route("/trinfo/<int:id>/", methods=["GET"])
def trinfo(id=None):
    trinfo = Trinfo.query.filter_by(tinfo_id=id).first_or_404()
    time_zero = datetime.timedelta(days=0)
    now = datetime.datetime.strptime(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "%Y-%m-%d %H:%M:%S")

    if "user" not in session:
        flash("请您先登录！", "err")
        return redirect(url_for("registration.login"))

    latest_infos = latest_Infos(6)

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/trinfo.html", trinfo=trinfo, time_zero=time_zero, latest_infos=latest_infos,
                           now=now, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


'''
理解本方法（admission_generate）：
    考试报名信息的id和用户id均由前台请求数据传过来，本方法的前提就是用户已登录，并且考试报名信息合理。
因为trinfo中对用户的登录状态进行了判断，此方法是在trinfo方法中跳转过来实现的，故不用去判断考试报名信息和
用户登录状态    
'''


# 准考证生成
@registration.route("/admission/<trinfo_id>/<user_id>/")
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
    examinfo = trinfo.tinfo.examroom[len(trinfo.tinfo.examroom)-3:]  # 取后3位数字
    if (trinfo.num + 1) % trinfo.tinfo.personnum == 0:
        seat = trinfo.tinfo.personnum
    else:
        if trinfo.num / 10 == 0:
            seat = str(0) + str((trinfo.num + 1) % trinfo.tinfo.personnum)  # 座位号，1到personnum
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
    return render_template("registration/registration_query.html", admissions=admissions)


# 准考证详情
@registration.route("/registration_detail/<int:id>/", methods=["GET"])
def registration_detail(id=None):
    admission = Admission.query.get_or_404(id)  # 根据id找出准考证
    # user = User.query.get_or_404(admission.user_id)  # 根据准考证找出当前用户，也可用session["user_id"]
    # trinfo = Trinfo.query.get_or_404(admission.trinfo_id)  # 根据准考证找出当前考试报名信息
    seat = admission.admission_id[len(admission.admission_id) - 2:]  # 座位号

    latest_infos = latest_Infos(6)

    zwgkNc, zwgkTags = affairs_public_tags()  # 激活右侧政务公开导航栏
    return render_template("registration/registration_detail.html", admission=admission, seat=seat,
                           latest_infos=latest_infos, zwgkNc=zwgkNc, zwgkTags=zwgkTags)


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
        session["user"] = user.email
        session["user_id"] = user.id
        userlog = Userlog(
            user_id=user.id,
            ip=request.remote_addr,
        )
        db.session.add(userlog)
        db.session.commit()
        return redirect(request.args.get("next") or url_for("registration.userinfo"))  # 登录后返回之前位置实现失败
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
    return render_template("registration/userinfo.html", form=form, user=user)


# 修改密码
@registration.route("/change_pwd/", methods=["GET", "POST"])
def change_pwd():
    form = ChangePwdForm()
    user = User.query.filter_by(id=session['user_id']).first_or_404()
    if form.validate_on_submit():
        data = form.data
        from werkzeug.security import generate_password_hash
        user.pwd = generate_password_hash(data["new_pwd"])
        db.session.add(user)
        db.session.commit()
        flash("修改密码成功，请重新登录！", "OK")
        return redirect(url_for('registration.logout'))
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
