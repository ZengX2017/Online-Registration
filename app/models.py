# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from datetime import datetime
from app import db


# 管理员
class Admin(db.Model):
    __tablename__ = "admin"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)
    pwd = db.Column(db.String(100))
    is_super = db.Column(db.SmallInteger)  # 是否为超级管理员,0为超级管理员
    # role_id = db.Column(db.Integer, db.ForeignKey('role.id'))  # 所属角色
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    adminlogs = db.relationship("Adminlog", backref='admin')  # 登录日志
    oplogs = db.relationship("Oplog", backref='admin')  # 操作日志
    newsinfos = db.relationship('NewsInfo', backref='admin')

    def __repr__(self):
        return "<Admin %r>" % self.name

    def check_pwd(self, pwd):
        from werkzeug.security import check_password_hash  # 验证哈希密码
        return check_password_hash(self.pwd, pwd)


# 管理员登录日志
class Adminlog(db.Model):
    __tablename__ = "adminlog"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))
    ip = db.Column(db.String(100))
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    def __repr__(self):
        return "<Adminlog %r>" % self.id


# 操作日志
class Oplog(db.Model):
    __tablename__ = "oplog"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))
    ip = db.Column(db.String(100))
    opdetail = db.Column(db.String(600))  # 操作详情
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    def __repr__(self):
        return "<Oplog %r>" % self.id


# 用户的数据模型
class User(db.Model):
    __tablename__ = "user"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100))
    pwd = db.Column(db.String(100))
    gender = db.Column(db.SmallInteger)  # 0为女生，1为男生
    email = db.Column(db.String(100), unique=True)
    id_card = db.Column(db.String(18), unique=True)
    phone = db.Column(db.String(11), unique=True)
    # info = db.Column(db.Text)  # 简介
    face = db.Column(db.String(255), unique=True)
    area = db.Column(db.String(200))
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    userlogs = db.relationship('Userlog', backref='user')  # 会员日志外键
    urinfos = db.relationship('Urinfo', backref='user')
    admissions = db.relationship('Admission', backref='user')
    # comments = db.relationship('Comment', backref='user')  # 评论外键

    def __repr__(self):
        return "<User %r>" % self.name

    def check_pwd(self, pwd):
        from werkzeug.security import check_password_hash
        return check_password_hash(self.pwd, pwd)


# 用户登陆日志
class Userlog(db.Model):
    __tablename__ = "userlog"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    ip = db.Column(db.String(100))
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    def __repr__(self):
        return "<Userlog %r>" % self.id


# 参考书
class Refbook(db.Model):
    __tablename__ = "refbook"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    title = db.Column(db.String(100))
    author = db.Column(db.String(100))
    ISBN = db.Column(db.String(13), unique=True)
    public = db.Column(db.String(100))
    pages = db.Column(db.Integer)
    logo = db.Column(db.String(255), unique=True)
    price = db.Column(db.Float)
    pubdate = db.Column(db.Date)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    tinfos = db.relationship("Tinfo", backref='refbook')

    def __repr__(self):
        return "<Refbook %r>" % self.title


# 考试级别
class Tlevel(db.Model):
    __tablename__ = "tlevel"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    level = db.Column(db.String(10), unique=True)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    tinfos = db.relationship("Tinfo", backref='tlevel')
    trinfos = db.relationship("Trinfo", backref='tlevel')
    urinfos = db.relationship("Urinfo", backref='tlevel')

    def __repr__(self):
        return "<Tlevel %r>" % self.level


# 考试科目
class Tsubject(db.Model):
    __tablename__ = "tsubject"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    subject = db.Column(db.String(100), unique=True)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    tinfos = db.relationship("Tinfo", backref='tsubject')
    trinfos = db.relationship("Trinfo", backref='tsubject')
    urinfos = db.relationship("Urinfo", backref='tsubject')

    def __repr__(self):
        return "<Tsubject %r>" % self.subject


# 考试信息
class Tinfo(db.Model):
    __tablename__ = "tinfo"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    level_id = db.Column(db.Integer, db.ForeignKey('tlevel.id'))
    subject_id = db.Column(db.Integer, db.ForeignKey('tsubject.id'))
    t_time = db.Column(db.DateTime)
    area = db.Column(db.String(255))
    examroom = db.Column(db.String(100))
    personnum = db.Column(db.Integer)
    price = db.Column(db.Float)
    refbook_id = db.Column(db.Integer, db.ForeignKey('refbook.id'))
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    admissions = db.relationship("Admission", backref='tinfo')

    def __repr__(self):
        return "<Tinfo %r %r>" % self.level_id.name, self.subject_id.name


# 考试报名信息
class Trinfo(db.Model):
    __tablename__ = "trinfo"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    level_id = db.Column(db.Integer, db.ForeignKey('tlevel.id'))
    subject_id = db.Column(db.Integer, db.ForeignKey('tsubject.id'))
    num = db.Column(db.Integer)
    price = db.Column(db.Float)
    status = db.Column(db.SmallInteger)  # 1表示可以报名，0表示不可以报名
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    def __repr__(self):
        return "<Trinfo %r %r>" % self.level_id.name, self.subject_id.name


# 用户报名信息
class Urinfo(db.Model):
    __tablename__ = "urinfo"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    level_id = db.Column(db.Integer, db.ForeignKey('tlevel.id'))
    subject_id = db.Column(db.Integer, db.ForeignKey('tsubject.id'))
    price = db.Column(db.Float)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    def __repr__(self):
        return "<Urinfo %r %r %r>" % self.user_id.name, self.level_id.name, self.subject_id.name


# 准考证
class Admission(db.Model):
    __tablename__ = "admission"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)
    admission_id = db.Column(db.String(18), unique=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    tinfo_id = db.Column(db.Integer, db.ForeignKey('tinfo.id'))
    status = db.Column(db.SmallInteger)  # 1表示可以打印，0表示不可以打印
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    def __repr__(self):
        return "<Admission %r>" % self.admission_id


# 新闻类别
class NewsCategory(db.Model):
    __tablename__ = "newscategory"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    newstags = db.relationship("NewsTag", backref='newscategory')

    def __repr__(self):
        return "<NewsCategory %r>" % self.name


# 新闻标签
class NewsTag(db.Model):
    __tablename__ = "newstag"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 标题
    newscategory_id = db.Column(db.Integer, db.ForeignKey('newscategory.id'))
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    newsinfos = db.relationship('NewsInfo', backref='newstag')

    def __repr__(self):
        return "<NewsTag %r>" % self.name


# 新闻资讯
class NewsInfo(db.Model):
    __tablename__ = "newsinfo"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    title = db.Column(db.String(100), unique=True)
    content = db.Column(db.String(20000))
    view_num = db.Column(db.Integer)
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))
    newstag_id = db.Column(db.Integer, db.ForeignKey('newstag.id'))
    img = db.Column(db.String(300))
    remark = db.Column(db.String(600))
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    def __repr__(self):
        return "<NewsInfo %r>" % self.title


# TEST
# class Test(db.Model):
#     __tablename__ = "test"
#     id = db.Column(db.Integer, primary_key=True)  # 编号
#     name = db.Column(db.String(100), unique=True)  # 标题
#     addtime = db.Column(db.DateTime, index=True, default=datetime.now)
#
#     def __repr__(self):
#         return "<Test %r>" % self.name


# if __name__ == "__main__":
#     # db.create_all()
#     from werkzeug.security import generate_password_hash
#     admin = Admin(
#         name="AdwardAdmin",
#         pwd=generate_password_hash("zx123"),
#         is_super=0
#     )
#     db.session.add(admin)
#     db.session.commit()