
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


@app.route('/register', methods=['GET', 'POST'])
def registration():
    messages = {'errors': []}
    if request.method == 'POST':
        username = request.form.get('username', '')
        password = request.form.get('password', '')
        password2 = request.form.get('password2', '')
        if username and password and password2:
            messages = users.validate_user({'username': username, 'password': password, 'password2': password2})
            if messages['valid_user']:
                if not users.register_user(username, password):
                    # Writing user to database failed
                    messages['errors'].append('An error occured. Please try again later or contact us!')
                else:
                    return redirect(url_for('login', new_user=True))
        else:
            messages['errors'].append('Please fill in all fields!')
    return render_template('registration.html', messages=messages)


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.args.get('new_user', False):
        messages = {'valid_user': True, 'errors': []}
    else:
        messages = {'valid_user': False, 'errors': []}

    if request.method == 'POST':
        username = request.form.get('username', '')
        password = request.form.get('password', '')
        if not (username and password):
            messages['errors'].append('Please fill in all fields!')
        else:
            if not users.verify_login(username, password):
                messages['errors'].append('Invalid credentials, try again!')
            else:
                users.login_user(username)
                return redirect(url_for('content'))
    return render_template('login.html', messages=messages)


@app.route('/logout')
@users.login_required
def logout():
    users.logout_user()
    return redirect(url_for('index'))


@app.before_request
def before_request():
    session.permanent = True
    app.permanent_session_lifetime = datetime.timedelta(minutes=20)
    session.modified = True


@app.route('/vote', methods=['POST'])
@users.login_required
def vote():
    result = jsonify(status=False)
    if request.method == 'POST':
        planet_name = request.form.get('planet_name', '')
        if planet_name:
            if votes.handle_vote(planet_name):
                result = jsonify(status=True)
    return result


@app.route('/vote-stats')
@users.login_required
def get_vote_statistics():
    return jsonify({'vote_stats': votes.get_votes()})
