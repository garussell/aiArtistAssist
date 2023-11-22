# app/services/api_service.rb
class ApiService
  def self.post_idea(prompt)
    response = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = prompt.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "http://localhost:3000/api/v1/post_idea") 
  end
end
