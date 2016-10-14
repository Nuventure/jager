require 'jager'
require 'base64'
require 'faraday'
require 'spec_helper'

describe Jager::CloudNet do

  before :all do
    @obj = Jager::CloudNet.new "authentication_string"
  end

  describe '.setup' do

    context 'connection with cloud.net' do

      it 'throw exception when arguments  are missing' do

        expect{Jager::CloudNet.setup "e-mail", "secret_key"}.to_not raise_exception ArgumentError
      
      end

      # it 'generate encripted authentication string for cloud.net' do 
      #   mail_id = "email"
      #   api_secret = "secret_key"
      #   encripted_auth_string = Base64.encode64("#{mail_id}:#{api_secret}")
      #   expect{Base64.encode64("#{mail_id}:#{api_secret}")}.to eq encripted_auth_string
      # end 

      it 'require authentication string and return object of Jager::CloudNet' do
        
        expect{Jager::CloudNet.new "authentication_string"}.to_not raise_exception
      
      end
    end 
  end

  # describe '#get_all_datacenters' do
    
  # end
end