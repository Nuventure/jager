module Jager
  class Datacenter < Jager::CloudNet
        
    def initialize obj
      super obj.authentication_string
    end
    
    def get_all_datacenters
      return collection_request "datacenters"
    end

    def get_datacenter id
      return member_request id, "datacenters"
    end
  end
end