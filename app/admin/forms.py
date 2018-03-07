# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, TextAreaField, FileField, IntegerField, FloatField, \
    DateField, DateTimeField, PasswordField
from wtforms.validators import DataRequired, EqualTo, ValidationError, length
from app.models import NewsCategory, NewsTag, Tlevel, Tsubject, Refbook, Admin
import re


class NewsCategoryForm(FlaskForm):
    name = StringField(
        label="添加新闻类别",
        validators=[
            DataRequired(message=u"请输入新闻类别")
        ],
        description="新闻类别",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入新闻类别",
        }  # 附加选项
    )
    submit = SubmitField(
        "编辑",
        render_kw={
            "class": "btn btn-primary",
        }  # 附加选项
    )


class NewsTagForm(FlaskForm):
    name = StringField(
        label="添加新闻标签",
        validators=[
            DataRequired("请输入新闻标签")
        ],
        description="新闻标签",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入新闻标签",
        }  # 附加选项
    )
    category = SelectField(
        label="所属新闻类别",
        validators=[
            DataRequired("请选择所属类别")
        ],
        coerce=int,
        # choices=[(v.id, v.name) for v in NewsCategory.query.all()],
        description="所属新闻类别",
        render_kw={
            "class": "form-control",
        }
    )
    submit = SubmitField(
        "编辑",
        render_kw={
            "class": "btn btn-primary",
        }  # 附加选项
    )


class NewsInfoForm(FlaskForm):
    title = StringField(
        label="标题",
        validators=[
            DataRequired("请输入资讯标题")
        ],
        description="资讯标题",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入资讯标题",
        }  # 附加选项
    )
    info = TextAreaField(
        label="内容",
        validators=[
            DataRequired("请输入资讯内容！")
        ],
        description="资讯内容",
        render_kw={
            "class": "summernote",
            "rows": 10
        }  # 附加选项
    )
    tag = SelectField(
        label="所属标签",
        validators=[
            DataRequired("请选择所属标签")
        ],
        coerce=int,
        # choices=[(nt.id, nt.name) for nt in NewsTag.query.all()],
        description="所属新闻标签",
        render_kw={
            "class": "form-control",
        }
    )
    img = FileField(
        label="图片",
        description="图片",
        render_kw={
            "id": "file-input"
        }
    )
    remark = TextAreaField(
        label="备注",
        description="备注",
        render_kw={
            "class": "form-control",
            "rows": 5
        }  # 附加选项
    )
    submit = SubmitField(
        "编辑",
        render_kw={
            "class": "btn btn-primary pull-right",
        }  # 附加选项
    )


class TlevelForm(FlaskForm):
    level = StringField(
        label="添加考试级别",
        validators=[
            DataRequired(message=u"请输入考试级别")
        ],
        description="考试级别",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入考试级别",
        }
    )
    submit = SubmitField(
        "编辑",
        render_kw={
            "class": "btn btn-primary",
        }  # 附加选项
    )


class TsubjectForm(FlaskForm):
    subject = StringField(
        label="添加考试科目",
        validators=[
            DataRequired(message=u"请输入考试科目")
        ],
        description="考试科目",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入考试科目",
        }
    )
    submit = SubmitField(
        "编辑",
        render_kw={
            "class": "btn btn-primary",
        }  # 附加选项
    )


class RefbookForm(FlaskForm):
    title = StringField(
        label="书名",
        validators=[
            DataRequired(message=u"请输入书名")
        ],
        description="书名",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入书名",
        }
    )
    author = StringField(
        label="作者",
        validators=[
            DataRequired(message=u"请输入作者名")
        ],
        description="作者",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入作者名",
        }
    )
    ISBN = StringField(
        label="ISBN",
        validators=[
            DataRequired(message=u"请输入ISBN"),
            length(13, message=u"请输入13位ISBN码")
        ],
        description="ISBN",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入ISBN",
        }
    )
    public = StringField(
        label="出版社",
        validators=[
            DataRequired(message=u"请输入出版社")
        ],
        description="出版社",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入出版社",
        }
    )
    pages = IntegerField(
        label="页码",
        validators=[
            DataRequired(message=u"请输入正确的页码"),

        ],
        description="页码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入页码",
        }
    )
    logo = FileField(
        label="封面",
        validators=[
            DataRequired(message=u"请选择封面")
        ],
        description="封面",
        render_kw={
            "class": "form-control",
            "id": "file-input",
            "placeholder": "请选择封面",
        }
    )
    price = FloatField(
        label="价格",
        validators=[
            DataRequired(message=u"请输入正确的价格")
        ],
        description="价格",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入价格",
        }
    )
    pubdate = StringField(
        label="出版日期",
        validators=[
            DataRequired(message=u"请选择出版日期")
        ],
        description="出版日期",
        render_kw={
            "class": "form-control",
            "id": "datepicker",
            "placeholder": "yyyy-mm-dd",
        }
    )
    info = TextAreaField(
        label="图书简介",
        validators=[
            DataRequired("请输入图书简介！")
        ],
        description="图书简介",
        render_kw={
            "class": "form-control",
            "rows": 10
        }  # 附加选项
    )
    submit = SubmitField(
        "编辑",
        render_kw={
            "class": "btn btn-primary pull-right",
        }  # 附加选项
    )

    def validate_price(self, field):
        price = str(field.data)
        pattern = re.compile(r'^([1-9][0-9]*)+(.[0-9]{1,2})?$')
        flag = pattern.search(price)
        if flag is None:
            raise ValidationError("请输入正确的价格！")


class TinfoForm(FlaskForm):
    tlevel = SelectField(
        label="考试级别",
        validators=[
            DataRequired(message=u"请选择考试级别")
        ],
        coerce=int,
        # choices=[(tl.id, tl.level) for tl in Tlevel.query.all()],
        description="考试级别",
        render_kw={
            "class": "form-control",
        }
    )
    tsubject = SelectField(
        label="考试科目",
        validators=[
            DataRequired(message=u"请选择考试科目")
        ],
        coerce=int,
        # choices=[(ts.id, ts.subject) for ts in Tsubject.query.all()],
        description="考试科目",
        render_kw={
            "class": "form-control",
        }
    )
    ttime = DateTimeField(
        label="考试时间",
        validators=[
            DataRequired(message=u"请选择考试时间")
        ],
        description="考试时间",
        render_kw={
            "class": "form-control",
            "id": "datetimepicker",
        },
    )
    province = StringField(
        description="省",
        render_kw={
            "class": "form-control",
            "id": "hidden-province",
            "type": "hidden"
        }
    )
    city = StringField(
        description="市",
        render_kw={
            "class": "form-control",
            "id": "hidden-city",
            "type": "hidden"
        }
    )
    school = StringField(
        description="学校",
        render_kw={
            "class": "form-control",
            "id": "hidden-school",
            "type": "hidden"
        }
    )
    examroom = StringField(
        label="考场",
        validators=[
            DataRequired(message=u"请输入考场")
        ],
        description="考场",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入考场",
        }
    )
    personnum = IntegerField(
        label="考试人数",
        validators=[
            DataRequired(message=u"请输入正确的考试人数")
        ],
        description="考试人数",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入考试人数",
        }
    )
    price = FloatField(
        label="报考价格",
        validators=[
            DataRequired(message=u"请输入正确的报考价格")
        ],
        description="报考价格",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入报考价格",
        }
    )
    ref_book = SelectField(
        label="所需参考书",
        validators=[
            DataRequired(message=u"请选择所需参考书")
        ],
        coerce=int,
        # choices=[(rb.id, rb.title) for rb in Refbook.query.all()],
        description="考试科目",
        render_kw={
            "class": "form-control",
        }
    )
    submit = SubmitField(
        "编辑",
        render_kw={
            "class": "btn btn-primary pull-right",
        }  # 附加选项
    )

    def validate_price(self, field):
        price = str(field.data)
        pattern = re.compile(r'^([1-9][0-9]*)+(.[0-9]{1,2})?$')
        flag = pattern.search(price)
        if flag is None:
            raise ValidationError("请输入正确的价格！")

    def validate_province(self, field):
        if (field.data is None) or (field.data == ""):
            raise ValidationError("请选择省！")

    def validate_city(self, field):
        if (field.data is None) or (field.data == ""):
            raise ValidationError("请选择市！")

    def validate_school(self, field):
        if (field.data is None) or (field.data == ""):
            raise ValidationError("请选择学校！")


class LoginForm(FlaskForm):
    name = StringField(
        validators=[
            DataRequired("请输入用户名！")
        ],
        description="用户名",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入用户名",
        }
    )
    pwd = PasswordField(
        validators=[
            DataRequired("请输入密码！")
        ],
        description="密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入密码",
        }  # 附加选项
    )
    submit = SubmitField(
        "登录",
        render_kw={
            "class": "btn btn-info w-md",
        }  # 附加选项
    )

    def validate_name(self, field):
        account = field.data
        admin = Admin.query.filter_by(name=account).count()
        if admin == 0:
            raise ValidationError("账号不存在！")


class ChangePwdForm(FlaskForm):
    pwd = PasswordField(
        label="原密码",
        validators=[
            DataRequired("请输入原密码！")
        ],
        description="原密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入原密码",
        }
    )
    new_pwd = PasswordField(
        label="新密码",
        validators=[
            DataRequired("请输入新密码！")
        ],
        description="新密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入新密码",
        }
    )
    re_new_pwd = PasswordField(
        label="重复新密码",
        validators=[
            DataRequired("请再次输入新密码！"),
            EqualTo('new_pwd', message=u"两次密码不一致")
        ],
        description="重复新密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请再次输入新密码",
        }
    )
    submit = SubmitField(
        "修改",
        render_kw={
            "class": "btn btn-primary pull-right",
        }
    )

    def validate_pwd(self, field):
        from flask import session
        pwd = field.data
        name = session["admin"]
        admin = Admin.query.filter_by(
            name=name
        ).first()
        if not admin.check_pwd(pwd):
            raise ValidationError("旧密码错误！")