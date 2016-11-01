module Jager

  class Datacenter < Base
    def initialize obj
      super obj
    end    
    def list
      return collection_request "datacenters"
    end

    def show id
      return member_request id, "datacenters"
    end
  end
end