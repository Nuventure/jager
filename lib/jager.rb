require 'base64'
require 'faraday'
require 'json'

require 'jager/base'
require 'jager/datacenter'
require 'jager/server'

module Jager

  # API_ENDPOINT = "https://api.cloud.net" its used for live data

  API_ENDPOINT = "https://api.staging.cloud.net/" #now testing with staging data.

  class CloudNet
    
    attr_accessor :authentication_string
    attr_accessor :connection
    def initialize auth_string
      @authentication_string = auth_string
      @connection = Faraday.new(API_ENDPOINT,{ssl: {verify: false}}) #its only for staging account
    end

    #initial connection setup encription with cloud.net

    def self.setup mail_id, api_secret
      auth_string = Base64.encode64("#{mail_id}:#{api_secret}")
      return self.new(auth_string) #creates new object of CloudNet for accessing all instance methods availabele 
    end
  end 
end
