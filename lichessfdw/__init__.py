"""
Lichess.org Foreign Data Wrapper
"""

from multicorn import ForeignDataWrapper
from multicorn.utils import log_to_postgres

import urllib2
import json

class LichessFDW(ForeignDataWrapper):

    def __init__(self,options,columns):
        super(LichessFDW,self).__init__(options,columns)

        # Constants
	# seems like the API limit is 200 anyway
	self.max_games_fetched = 1000;

	# Parse options 
	self.username = options.get('username',None)
	self.api_url = options.get('api_url','http://lichess.org/api/')

	# Get list of requested columns
        self.columns=columns

        # DEBUG
        #log_to_postgres("Lichess.org FDW loaded : %s" % __file__)

    def fetch(self) :

	options  = '&nb=' + str(self.max_games_fetched)
	options += '&with_analysis=1'
	options	+= '&with_moves=1'
        options += '&with_opening=1'

	url = self.api_url + 'game?username='+ self.username + options
	response = json.load(urllib2.urlopen(url))

        return response['list']


    def execute(self, quals, columns):

        for game in self.fetch():
            output = {}
            for column_name in self.columns:
                if column_name in game :
			output[column_name] = game[column_name]
		else:
			output[column_name] = None
            yield output
