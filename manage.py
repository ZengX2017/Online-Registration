# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from app import app
from app import db
from app.models import *
from flask_script import Manager
from flask_migrate import Migrate, MigrateCommand


migrate = Migrate(app, db)
manage = Manager(app)
manage.add_command('db', MigrateCommand)

if __name__ == "__main__":
    app.run()

# 数据迁移的时候用
# if __name__ == "__main__":
#     manage.run()