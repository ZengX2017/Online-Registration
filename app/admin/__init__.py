# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import Blueprint

admin = Blueprint("admin", __name__)

import app.admin.views