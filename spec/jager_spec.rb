require 'jager'
require 'base64'
require 'faraday'
require 'spec_helper'
require 'vcr'
require 'support/vcr_setup'

describe Jager::CloudNet do

  before :all do
    @obj = Jager::CloudNet.new "authentication_string"
  end

  describe '.setup' do

    context 'connection with cloud.net' do

      it 'throw exception when arguments  are missing' do

        expect{Jager::CloudNet.setup "e-mail", "secret_key"}.to_not raise_exception ArgumentError
      
      end

      it 'generate encripted authentication string for cloud.net' do 
        mail_id = "email"
        api_secret = "secret_key"
        encripted_auth_string = Base64.encode64("#{mail_id}:#{api_secret}")
        expect(encripted_auth_string).to eql encripted_auth_string
      end 

      it 'require authentication string and return object of Jager::CloudNet' do
        
        expect{Jager::CloudNet.new "authentication_string"}.to_not raise_exception
      
      end
    end 
  end

  describe '#get_all_datacenters' do
    context 'with invalid credentials' do
      it 'returns authentication error message' do
        VCR.use_cassette 'datacenters/all_with_invalid_creds' do
          response = @obj.get_all_datacenters
          expect(response[:status]).to eql 401 
        end
      end 
    end

    context 'with valid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'returns all datacenters' do
        VCR.use_cassette 'datacenters/all_with_valid_creds' do
          response = obj.get_all_datacenters
          expect(response[:status]).to eql 200
        end
      end
    end
  end

  describe '#get_datacenter' do
    context " without datacenter id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:get_datacenter).with(1)
        @obj.get_datacenter 1
      end
    end
    context "with datacenter id and invalid credentials" do 
      it 'returns authentication error message' do
        VCR.use_cassette 'datacenters/one_with_invalid_creds' do
          response = @obj.get_datacenter 1
          expect(response[:status]).to eql 401 
        end
      end 
    end

    context 'with datacenter id and invalid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'returns datacenter' do
        VCR.use_cassette 'datacenters/one_with_valid_creds' do
          response = obj.get_datacenter 1
          expect(response[:status]).to_not eql 401
        end
      end
    end
  end

  describe '#get_all_servers' do
    context 'with invalid credentials' do
      it 'returns authentication error message' do
        VCR.use_cassette 'servers/all_with_invalid_creds' do
          response = @obj.get_all_servers
          expect(response[:status]).to eql 401          
        end
      end   
    end
    context 'with valid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'returns all servers' do
        VCR.use_cassette 'servers/all_with_valid_creds' do
          response = obj.get_all_servers
          expect(response[:status]).to eql 200
        end  
      end
    end
  end

  describe '#get_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:get_server).with(1)
        @obj.get_server 1
      end
    end
    context "with server id and invalid credentials" do 
      it 'retuns authentication error message' do
        VCR.use_cassette 'servers/one_with_invalid_creds' do
          response = @obj.get_server 1
          expect(response[:status]).to eql 401
        end
      end
    end
    context 'with server id and valid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'retuns server' do
        VCR.use_cassette 'servers/one_with_valid_creds' do
          response = obj.get_server 1
          expect(response[:status]).to_not eql 401  
        end
      end 
    end
  end

  describe '#create_server' do
    context " without template id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:create_server).with(1,any_args)
        @obj.create_server 1, {name: nil}
      end
    end
    context "with template id and invalid credentials" do 
      it 'returns authentication error message' do
        VCR.use_cassette 'servers/create_server_with_invalid_creds' do
          response = @obj.create_server 1
          expect(response[:status]).to eql 401
        end 
      end
    end
    context 'with valid template id and valid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'creates one server' do
        VCR.use_cassette 'servers/create_server_with_valid_creds' do
          response = obj.create_server 1
          expect(response[:status]).to_not eql 401
        end 
      end
    end
  end

  describe '#edit_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:edit_server).with(1,any_args)
        @obj.edit_server 1, {memory: nil, cpus: nil, disk_size: nil}
      end
    end
    context "with server id and invalid credentials" do 
      it 'returns authentication error' do
        VCR.use_cassette 'servers/edit_server_with_invalid_creds' do
          response = @obj.edit_server 1
          expect(response[:status]).to eql 401
        end
      end
    end
    context 'with server id and valid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'edit one server' do
        VCR.use_cassette 'servers/edit_server_with_valid_creds' do
          response = obj.edit_server 169
          expect(response[:status]).to_not eql 401
        end 
      end
    end
  end

  describe '#destroy_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:destroy_server).with(1)
        @obj.destroy_server 1
      end
    end
    context "with server id and invalid credentials" do 
      it 'returns authentication error message' do
        VCR.use_cassette 'servers/destroy_server_with_invalid_creds' do
          response = @obj.destroy_server 1
          expect(response[:status]).to eql 401
        end
      end
    end

    context "with server id and valid credentials" do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'delete one server' do
        VCR.use_cassette 'servers/destroy_server_with_valid_creds' do 
          response = obj.destroy_server 1
          expect(response[:status]).to_not eql 401
        end
      end   
    end
  end

  describe '#reboot_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:reboot_server).with(1)
        @obj.reboot_server 1
      end
    end
    context "with server id and invalid credentials" do 
      it 'returns authentication error message' do
        VCR.use_cassette 'servers/reboot_server_with_invalid_creds' do
          response = @obj.reboot_server 1
          expect(response[:status]).to eql 401
        end
      end
    end
    context 'with server id and valid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'reboots server' do
        VCR.use_cassette 'servers/reboot_server_with_valid_creds' do
          response = obj.reboot_server 1
          expect(response[:status]).to_not eql 401
        end
      end
    end
  end

  describe '#shutdown_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:shutdown_server).with(1)
        @obj.shutdown_server 1
      end
    end
    context "with server id and invalid credentials" do
      it 'it returns authentication error message' do
        VCR.use_cassette 'servers/shutdown_server_with_invalid_creds' do
          response = @obj.shutdown_server 1
          expect(response[:status]).to eql 401
        end
      end 
    end
    context "with server id and valid credentials" do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'shutdown the server' do
        VCR.use_cassette 'servers/shutdown_server_with_valid_creds' do
          response = obj.shutdown_server 1
          expect(response[:status]).to_not eql 401
        end
      end 
    end
  end


  describe '#startup_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:startup_server).with(1)
        @obj.startup_server 1
      end
    end
    context "with server id and invalid credentials" do 
      it 'returns authentication error message' do
        VCR.use_cassette 'servers/startup_server_with_invalid_creds' do
          response = @obj.startup_server 1
          expect(response[:status]).to eql 401
        end
      end
    end
    context 'with server id and valid credentials' do
      obj = Jager::CloudNet.setup ENV["CLOUDNET_EMAIL"], ENV["CLOUDNET_API_KEY"]
      it 'startup the server' do
        VCR.use_cassette 'servers/startup_server_with_valid_creds' do
          response = obj.startup_server 1
          expect(response[:status]).to_not eql 401
        end      
      end      
    end
  end
end