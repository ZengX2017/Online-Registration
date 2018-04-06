# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask_wtf import FlaskForm
from wtforms.validators import DataRequired, EqualTo, ValidationError, Email, Regexp
from wtforms import StringField, PasswordField, SubmitField, SelectField, FileField, TextAreaField
from app.models import User


class RegisterForm(FlaskForm):
    name = StringField(
        label="姓名（可选）",
        # validators=[
        #     DataRequired("请输入您的姓名！")
        # ],
        description="姓名",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入您的姓名",
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
    #     description="验证码",
    #     render_kw={
    #         "class": "form-control",
    #     }
    # )
    submit = SubmitField(
        "注册",
        render_kw={
            "class": "btn btn-default",
        }
    )

    def validate_email(self, field):
        email = field.data
        user = User.query.filter_by(email=email).count()
        if user == 1:
            raise ValidationError("账号已经存在！")


class LoginForm(FlaskForm):
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
    # captcha = StringField(
    #     label="验证码",
    #     description="验证码",
    #     render_kw={
    #         "class": "form-control",
    #     }
    # )
    submit = SubmitField(
        "登录",
        render_kw={
            "class": "btn btn-default",
        }
    )

    def validate_email(self, field):
        email = field.data
        user = User.query.filter_by(email=email).count()
        if user == 0:
            raise ValidationError("账号不存在！")


class UserInfoForm(FlaskForm):
    name = StringField(
        label="姓名",
        validators=[
            DataRequired("请输入姓名！")
        ],
        description="姓名",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入姓名",
        }
    )
    gender = SelectField(
        label="性别",
        coerce=int,
        choices=[(1, '男'), (0, '女')],
        description="性别",
        render_kw={
            "class": "form-control",
        }
    )
    # email = StringField(
    #     label="邮箱",
    #     validators=[
    #         DataRequired("请输入邮箱！"),
    #         Email(message=u"邮箱格式不对！请重新输入！")
    #     ],
    #     description="邮箱",
    #     render_kw={
    #         "class": "form-control",
    #         "placeholder": "请输入邮箱",
    #     }
    # )
    id_card = StringField(
        label="身份证",
        validators=[
            DataRequired("请输入身份证！"),
            # length(18, 18, message=u"请输入正确的身份证号码！"),
            Regexp("\d{18}", message=u"请输入正确的身份证号码！")
        ],
        description="身份证",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入身份证",
        }
    )
    phone = StringField(
        label="手机号码",
        validators=[
            DataRequired("请输入手机号码！"),
            Regexp("1[3458]\\d{9}", message=u"手机格式不正确！")
        ],
        description="手机号码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入手机号码",
        }
    )
    face = FileField(
        label="头像",
        description="头像",
        render_kw={
            "id": "file-input"
        }
    )
    area = StringField(
        label="地址",
        description="地址",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入地址",
        }
    )
    submit = SubmitField(
        "修改",
        render_kw={
            "class": "btn btn-default pull-right",
        }
    )


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
            "class": "btn btn-default pull-right",
        }
    )

    def validate_pwd(self, field):
        from flask import session
        pwd = field.data
        user = User.query.filter_by(
            id=session["user_id"]
        ).first()
        if not user.check_pwd(pwd):
            raise ValidationError("旧密码错误！")


class AdviceForm(FlaskForm):
    content = TextAreaField(
        label="内容",
        validators=[
            DataRequired("请输入内容！")
        ],
        description="内容",
        render_kw={
            "id": "summernote",
            "class": "form-control",
            "rows": 10
        }
    )
    name = StringField(
        label="姓名",
        description="姓名",
        render_kw={
            "class": "form-control",
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
        }
    )
    submit = SubmitField(
        "提交",
        render_kw={
            "class": "btn btn-primary pull-right",
        }  # 附加选项
    )


class ForgetPwdForm(FlaskForm):
    email = StringField(
        label="邮箱",
        validators=[
            DataRequired("请输入您的邮箱！"),
            Email(message=u"邮箱格式不正确，请重新输入！")
        ],
        description="邮箱",
        render_kw={
            "class": "form-control",
        }
    )
    submit = SubmitField(
        "提交",
        render_kw={
            "class": "btn btn-default",
        }
    )