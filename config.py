# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

class Config(object):
    pass


class ProdConfig(object):
    pass


class DevConfig(object):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = "mysql+pymysql://root:zx123456@127.0.0.1:3306/online-registration"
