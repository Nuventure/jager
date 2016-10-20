 class Server < Base
  def get_all_servers
    return collection_request "servers"
  end

  def get_server id
    return member_request id, "servers"
  end

  # server CRUD actions

  def create_server template_id, options = {}
    options = {name: nil, hostname: nil, memory: 1024, disk_size: 20, cpus: 2}.merge(options)
    resp = @connection.post("#{API_ENDPOINT}/servers") do |req|
      req.headers["Authorization"] = "Basic #{@authentication_string}"
      req.params["template_id"] = template_id 
      req.params["name"] = options[:name]
      req.params["hostname"] = options[:hostname] 
      req.params["memory"] = options[:memory] 
      req.params["disk_size"] = options[:disk_size] 
      req.params["cpus"] = options[:cpus]
    end
    return JSON.parse(resp.body)   
  end

  def edit_server server_id, options = {}
    options = {template_id: nil, memory: nil, cpus: nil, disk_size: nil}.merge(options)
    resp = @connection.put("#{API_ENDPOINT}/servers/#{server_id}") do |req|
      req.headers["Authorization"] = "Basic #{@authentication_string}"
      req.params["template_id"] = options[:template_id] 
      req.params["memory"] = options[:memory]           
      req.params["disk_size"] = options[:disk_size]     
      req.params["cpus"] = options[:cpus]            
      req.params["id"] = server_id
    end
    return JSON.parse(resp.body)
  end

  def destroy_server id
    resp = @connection.delete("#{API_ENDPOINT}/servers/#{id}") do |req|
      req.headers["Authorization"] = "Basic #{@authentication_string}"
    end
  end

  #server power options

  def reboot_server id
    return power_options id,"reboot"
  end

  def shutdown_server id
    return power_options id,"shutdown"
  end

  def startup_server id
    return power_options id,"startup"
  end
end