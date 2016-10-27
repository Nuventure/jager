module Jager

  class Datacenter < Jager::Base
    def initialize obj
      super obj
    end    
    def get_all_datacenters
      return collection_request "datacenters"
    end

    def get_datacenter id
      return member_request id, "datacenters"
    end
  end
end