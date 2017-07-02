
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
