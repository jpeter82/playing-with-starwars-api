
import db
import users
from flask import session


def check_user_vote(user_id, planet_id):
    '''
    Check for existing user vote
        @param     user_id      int    User ID
        @param     planet_id    int    Planet ID
        @return                 list   All details of the vote or empty list
    '''
    sql = '''SELECT *
             FROM mjkwnf_planet_votes
             WHERE user_id = %s AND planet_id = %s'''
    data = (user_id, planet_id)
    result = db.perform_query(sql, data)
    return result


def get_planet_by_name(planet_name):
    '''
    Retrieve planet details by its name
        @param    planet_name    string    Name of the planet the be found
        @return                  list      Contains the details of the planet or empty list
    '''
    sql = '''SELECT id
             FROM mjkwnf_planets
             WHERE planet_name = %s'''
    data = (planet_name,)
    result = db.perform_query(sql, data)
    return result
