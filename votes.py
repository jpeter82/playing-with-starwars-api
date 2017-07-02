
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


def insert_vote(user_id, planet_id):
    '''
    Insert new user vote
        @param     user_id      int    User ID
        @param     planet_id    int    Planet ID
        @return                 list   All details of inserted vote
    '''
    sql = '''INSERT INTO mjkwnf_planet_votes (user_id, planet_id)
             VALUES (%s, %s)
             RETURNING *'''
    data = (user_id, planet_id)
    result = db.perform_query(sql, data)
    return result


def delete_vote(user_id, planet_id):
    '''
    Delete a user vote
        @param     user_id      int    User ID
        @param     planet_id    int    Planet ID
        @return                 list   All details of deleted vote
    '''
    sql = '''DELETE FROM mjkwnf_planet_votes
             WHERE user_id = %s AND planet_id = %s
             RETURNING *'''
    data = (user_id, planet_id)
    result = db.perform_query(sql, data)
    return result


def get_votes():
    '''
    Prepares data for vote statistics, contains TOP 10 voted planets
        @return   list   List of planets with number of votes
    '''
    sql = '''SELECT p.planet_name, COUNT(p.planet_name) vote_count
             FROM mjkwnf_planet_votes pv
             INNER JOIN mjkwnf_planets p ON pv.planet_id = p.id
             GROUP BY p.planet_name
             ORDER BY vote_count DESC, planet_name
             LIMIT 10;'''
    result = db.perform_query(sql)
    return result


def get_votes_by_user_id(user_id):
    '''
    Get votes of a specific user
        @param     user_id    int    User ID
        @return               list   List of planet names the user voted on
    '''
    sql = '''SELECT string_agg(DISTINCT p.planet_name, ',') as voted_planets
             FROM mjkwnf_planet_votes pv
             INNER JOIN mjkwnf_planets p ON p.id = pv.planet_id
             WHERE user_id = %s
             GROUP BY user_id'''
    data = (user_id,)
    result = db.perform_query(sql, data)[0]['voted_planets'].split(',')
    return result


def handle_vote(planet_name):
    '''
    Contains voting logic. Only one vote is allowed on a planet, it adds or deletes
    the vote of the user.
        @param    planet_name    string    Name of the planet the user votes on
        @return                  list      Contains the details of the added/deleted vote
    '''
    user_id = users.get_user_by_username(session.get('username'))[0]['id']
    planet_id = get_planet_by_name(planet_name)[0]['id']
    if check_user_vote(user_id, planet_id):
        result = delete_vote(user_id, planet_id)
    else:
        result = insert_vote(user_id, planet_id)
    return result
