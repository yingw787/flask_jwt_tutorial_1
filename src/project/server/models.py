# project/server/models.py

import datetime

from project.server import app, db, bcrypt


class User(db.Model):
    """User Model for storing user-related details.
    """
    __tablename__ = "users"
