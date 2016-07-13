class UserService

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new("https://api.github.com")
    @connection.headers["Authorization"] = "token #{current_user.token}"
  end

  def stars
    response = @connection.get("/user/starred")
    parse(response)
  end

  def activities
    response = @connection.get("/users/#{@current_user.nickname}/events")
    parse(response)
  end

  def parse(response)
    JSON.parse(response.body)
  end

end
