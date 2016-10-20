class Datacenter < Base
  def get_all_datacenters
    return collection_request "datacenters"
  end

  def get_datacenter id
    return member_request id, "datacenters"
  end
end