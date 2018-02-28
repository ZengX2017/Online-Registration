# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask_wtf import FlaskForm
from wtforms.validators import DataRequired, EqualTo, ValidationError, length, Email
from wtforms import StringField, PasswordField, SubmitField
from app.models import User


class RegisterForm(FlaskForm):
    name = StringField(
        label="账号",
        validators=[
            DataRequired("请输入您的账号！")
        ],
        description="账号",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入您的账号",
        }
    )
    email = StringField(
        label="邮箱",
        validators=[
            DataRequired("请输入您的邮箱！"),
            Email(message=u"邮箱格式不正确，请重新输入！")
        ],
        description="邮箱",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入您的邮箱",
        }
    )
    pwd = PasswordField(
        label="密码",
        validators=[
            DataRequired("请输入您的密码！")
        ],
        description="密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入您的密码",
        }
    )
    re_pwd = PasswordField(
        label="重复密码",
        validators=[
            DataRequired("请再次输入新密码！"),
            EqualTo('pwd', message=u"两次密码不一致")
        ],
        description="重复密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请再次输入您的密码",
        }
    )
    # captcha = StringField(
    #     label="验证码",
    #     validators=[
    #         DataRequired("请输入图中的验证码！"),
    #     ],
    #     description="验证码",
    #     render_kw={
    #         "class": "form-control",
    #         "placeholder": "请输入图中的验证码",
    #     }
    # )
    submit = SubmitField(
        "注册",
        render_kw={
            "class": "btn btn-default",
        }
    )

    def validate_name(self, field):
        name = field.data
        user = User.query.filter_by(name=name).count()
        if user == 1:
            raise ValidationError("账号已经存在！")

    def validate_email(self, field):
        email = field.data
        user = User.query.filter_by(email=email).count()
        if user == 1:
            raise ValidationError("邮箱已经存在！")


class LoginForm(FlaskForm):
    name = StringField(
        label="账号",
        validators=[
            DataRequired("请输入您的账号！")
        ],
        description="账号",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入您的账号",
        }
    )
    pwd = PasswordField(
        label="密码",
        validators=[
            DataRequired("请输入您的密码！")
        ],
        description="密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入您的密码",
        }
    )
    submit = SubmitField(
        "登录",
        render_kw={
            "class": "btn btn-default",
        }
    )


