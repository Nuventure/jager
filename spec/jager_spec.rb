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
    subject {@obj.get_all_datacenters}
    it 'retun error message for wrong request' do
      expect(subject).to have_key("error")
    end
  end

  describe '#get_datacenter' do
    context " without datacenter id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:get_datacenter).with(1)
        @obj.get_datacenter 1
      end
    end
    context "with datacenter id" do 
      subject {@obj.get_datacenter(1)}
      it 'retun error message for wrong request' do
        expect(subject).to have_key("error") 
      end
    end
  end

  describe '#get_all_servers' do
    subject {@obj.get_all_servers}
    it 'retun error message for wrong request' do
      expect(subject).to have_key("error")
    end
  end

  describe '#get_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:get_server).with(1)
        @obj.get_server 1
      end
    end
    context "with server id" do 
      subject {@obj.get_server(1)}
      it 'retun error message for wrong request' do
        expect(subject).to have_key("error") 
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
    context "with template id" do 
      subject {@obj.create_server(1, name: "testserver")}
      it 'retun error message for wrong request' do
        expect(subject).to have_key("error") 
      end
    end
  end

  describe '#edit_server' do
    context " without server id" do
      it 'throw ArgumentError' do
        expect(@obj).to receive(:edit_server).with(1,any_args)
        @obj.edit_server 1, {name: nil, memory: nil, cpus: nil, disk_size: nil}
      end
    end
    context "with server id" do 
      subject {@obj.edit_server(1, name: "testserver_edited", memory: 1024, cpus: 2, disk_size: 20)}
      it 'retun error message for wrong request' do
        expect(subject).to have_key("error") 
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
    context "with server id" do 
      subject {@obj.destroy_server(1)}
      it 'retuns one Faraday response instance' do
        expect(subject).to be_an_instance_of Faraday::Response
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
    context "with server id" do 
      subject {@obj.reboot_server(1)}
      it 'retun error message for wrong request' do
        expect(subject).to have_key("error") 
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
    context "with server id" do 
      subject {@obj.shutdown_server(1)}
      it 'retun error message for wrong request' do
        expect(subject).to have_key("error") 
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
    context "with server id" do 
      subject {@obj.startup_server(1)}
      it 'retun error message for wrong request' do
        expect(subject).to have_key("error") 
      end
    end
  end
end