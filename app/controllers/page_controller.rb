class PageController < ApplicationController

	def index
	end

	def api
		resp = RestClient.get("https://www.metaweather.com/api/location/1062617")
		hash = JSON.parse(resp.body)
		@weathers = hash["consolidated_weather"]

		# resp = RestClient.get("http://quotes.rest/qod")
		# hash = JSON.parse(resp.body)
		# @quotes = hash["contents"]["quotes"]

		resp2 = RestClient.get("https://talaikis.com/api/quotes/random/")
		hash = JSON.parse(resp2.body)
		@quote = hash["quote"]
		@author = hash["author"]
		@cat = hash["cat"]

		resp3 = RestClient.get("http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1")
		hash = JSON.parse(resp3.body)
		@title = hash[0]["title"]
		@content = hash[0]["content"]




	end



end
