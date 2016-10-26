module jager

  class Base

    protected

      def collection_request type
        #send intial request for getting full response header and use total 
        #number of results to get all data in one request.
        
        resp = @connection.get("#{API_ENDPOINT}/#{type}") do |req|
          req.headers["Authorization"] = "Basic #{@authentication_string}" 
        end
        total_results = resp.headers["x-total"]
        
        #get all in one request

        full_data = @connection.get("#{API_ENDPOINT}/#{type}") do |req|
          req.params["per_page"] = total_results.to_i
          req.params["pege"] = 1
          req.headers["Authorization"] = "Basic #{@authentication_string}" 
        end

        return JSON.parse(full_data.body)

      end

      def member_request id, type
        resp = @connection.get("#{API_ENDPOINT}/#{type}/#{id}") do |req|
          req.headers["Authorization"] = "Basic #{@authentication_string}" 
        end
        return JSON.parse(resp.body) 
      end

      def power_options server_id, option
        resp = @connection.put("#{API_ENDPOINT}/servers/#{server_id}/#{option}") do |req|
          req.headers["Authorization"] = "Basic #{@authentication_string}"
        end
        return JSON.parse(resp.body)
      end
  end
end