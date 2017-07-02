
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
from flask import session, redirect, url_for
import db
import re

'''
Validation functions
'''


def validate_user(user_to_be):
    '''
    Contains validation logic upon new registration
        @param     user_to_be    dict    Contains form data provided be new user
        @return                  dict    Status for validity and a list of errors if present
    '''
    valid_status = {}
    valid_username = validate_username(user_to_be['username'])
    valid_password = validate_password(user_to_be['password'], user_to_be['password2'])

    valid_status['valid_user'] = True if (valid_username['status'] and valid_password['status']) else False

    if not valid_status['valid_user']:
        valid_status['errors'] = valid_username['errors'] + valid_password['errors']

    return valid_status


def validate_username(username):
    '''
    Validate new user name upon new registration. User name might contain only lowercase and uppercase letters, digits,
    underscore or hyphen. Length must be min 5, max 50 characters. Username must be unique!
        @param    username    string    The username to be validated
        @return               dict      Status for validity and a list of errors if present
    '''
    result = {'status': False}
    if username:
        is_valid_format = True if re.match(r"^[a-zA-Z0-9_-]{5,50}$", username) else False
        not_existing_user = True if not get_user_by_username(username) else False
        valid_username = (is_valid_format and not_existing_user)

        result = {
            'status': valid_username,
            'errors': []
        }

        if not is_valid_format:
            result['errors'].append('username must be min 5, max 50 chars, and can only contain letters, \
                                    digits, underscore and hyphen!')

        if not not_existing_user:
            result['errors'].append('username is already taken!')

    return result


def validate_password(password, password2):
    '''
    Validate password upon registration. A password must be min 6 chars, must contain at least of the following:
    uppercase, lowercase, special symbol char and a digit. Password also needs to match Password Again.
        @param     password      string     Password to check
        @param     password2     string     Password Again to check
        @return                  dict       Status for validity and a list of errors if present
    '''
    result = {'status': False}
    if password and password2:
        length_error = len(password) < 6
        digit_error = re.search(r"\d", password) is None
        uppercase_error = re.search(r"[A-Z]", password) is None
        lowercase_error = re.search(r"[a-z]", password) is None
        symbol_error = re.search(r"[\W_]", password) is None
        matching_error = password != password2
        valid_password = not (length_error or digit_error or uppercase_error or
                              lowercase_error or symbol_error or matching_error)

        result = {
            'status': valid_password,
            'errors': []
        }

        if length_error:
            result['errors'].append('password must be min 6 characters!')

        if digit_error:
            result['errors'].append('password must contain at least one digit!')

        if uppercase_error:
            result['errors'].append('password must contain at least one uppercase letter!')

        if lowercase_error:
            result['errors'].append('password must contain at least one lowercase letter!')

        if symbol_error:
            result['errors'].append('password must contain at least one special character! (i.e !?&#-_\/&<>%)')

        if matching_error:
            result['errors'].append('password does not match password again!')

    return result


def verify_login(username, password):
    '''
    Check user credentials for logging in
        @param     username    string    The username to check
        @param     password    string    The password to check
        @return                bool      True if credentials match, otherwise False
    '''
    status = False
    db_user = get_user_by_username(username)[0]
    if db_user:
        if (db_user['username'] == username) and check_password_hash(db_user['password'], password):
            status = True
    return status


'''
Login and Registration functions
'''


def register_user(username, password):
    '''
    Register new, validated user, store credentials in db
        @param    username    string    User name provided by new user
        @param    password    string    Password provided by new user in plain text
        @return               bool      True if successful, otherwise False
    '''
    status = False
    if username and password:
        sql = '''INSERT INTO mjkwnf_users (username, password) VALUES (%s, %s) RETURNING id'''
        data = (username, hash_password(password))
        status = True if db.perform_query(sql, data) else False
    return status


def login_user(username):
    ''' Log user in, put username in session'''
    if username:
        session.clear()
        session['username'] = username


def logout_user():
    ''' Log user out, clear everything from session'''
    session.clear()


def login_required(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if 'username' in session:
            return func(*args, **kwargs)
        return redirect(url_for('login'))
    return wrapper


'''
Helper functions
'''


def get_user_by_username(username):
    '''
    Get all details of a user by its user name
        @param    username    int     The name of the user to be found
        @return               list    All details of the user or empty list if user does not exist in db
    '''
    result = None
    if username:
        sql = '''SELECT * FROM mjkwnf_users WHERE username = %s'''
        data = (username,)
        result = db.perform_query(sql, data)
    return result


def get_user_by_id(user_id):
    '''
    Get all details of a user by its ID
        @param    user_id    int     The ID of the user to be found
        @return              list    All details of the user or empty list if user does not exist in db
    '''
    result = None
    if user_id:
        sql = '''SELECT * FROM mjkwnf_users WHERE id = %s'''
        data = (user_id,)
        result = db.perform_query(sql, data)
    return result


def hash_password(password):
    '''
    Make a hashed version of the provided password
        @param    password     string     The password to be hashed
        @return                string     The hashed password
    '''
    hashed_password = generate_password_hash(password, method='pbkdf2:sha512:20000', salt_length=8)
    return hashed_password
