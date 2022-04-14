from flask_table import Table, Col
 
class Results(Table):
    user_id = Col('Id')
    user_name = Col('Name')
    user_email = Col('Email')
    user_bio = Col('Bio')