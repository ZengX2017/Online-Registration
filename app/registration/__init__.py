# -*- coding: utf-8 -*-
__author__ = 'Adward_Z'

from flask import Blueprint

registration = Blueprint("registration", __name__)

import app.registration.views
