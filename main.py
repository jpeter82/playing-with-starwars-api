
from flask import Flask, render_template, url_for, session, redirect, request, jsonify
import datetime
import settings
import users
import votes
import os

app = Flask(__name__)
app.secret_key = os.urandom(24)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/content')
@users.login_required
def content():
    return render_template('content.html')